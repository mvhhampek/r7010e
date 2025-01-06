clc
close all

ranges_vals = ranges_exp.Data;
x_vals = x_exp.Data;
y_vals = y_exp.Data;
theta_vals = theta_exp.Data;
ang_vel_vals = ang_vel_exp.Data;
n = length(x_vals);
angles = linspace(0, 2*pi, 360);
%%

map_size = 15; 
map_res = 20;

map = occupancyMap(map_size, map_size, map_res);

for i = 1:n
    ranges = ranges_vals(i, :);
    x = x_vals(i);
    y = y_vals(i);
    theta = theta_vals(i);
    ang_vel = ang_vel_vals(i);
    occupancy_map(map, x, y, theta, ang_vel, i-1, ranges');
end

map2 = binaryOccupancyMap(getOccupancy(map) > 0.5);


start = round(irl_to_path([x_vals(end), y_vals(end)], 20, 15))
goal = irl_to_path([0, 0], 20, 15)

processed_map = post_process_map(map2);
mtx_map = occupancyMatrix(processed_map);
%%
% av nån anledning så flippas den vertikalt? ? ? ?? ? ????
ds = Dstar(flipud(mtx_map), 'inflate', 3);

ds.plan(goal);
path = ds.query(start);
ds.plot(path)

irl_path = path_to_irl(path, 20, 15);
x_path = irl_path(:,1); 
x_path = x_path(4:4:end);
y_path = irl_path(:,2);
y_path = y_path(4:4:end);
hold off

figure
plot(x_path, y_path, 'ro')

axis equal
%%
show(post_process_map(map2))
%% plot after running

x_vals = x_exp.Data;
y_vals = y_exp.Data;
robot_path = irl_to_path([x_vals y_vals], 20, 15);
show(post_process_map(map2))
hold on 

plot(robot_path(:,1), robot_path(:,2), 'r-', 'Linewidth', 2)
hold on
scatter(goal(1), goal(2), 100,'yellowx','Linewidth', 2)
hold on
scatter(start(1), start(2), 100, 'blueo','Linewidth', 2)
legend('Robots trajectory','Goal','Start')
xlabel('X');ylabel('Y');title('Robot following path');
%%
function irl_path = path_to_irl(path, map_res, map_size)
    path = path - map_size*10;
    irl_path = path/map_res;
end

function path = irl_to_path(irl_path, map_res, map_size)
    path = irl_path*map_res + map_size*10;
end

function processed_map = post_process_map(map)
    mtx_map = occupancyMatrix(map);
    G = fspecial('gaussian', [5 5], 1);
    mtx_map = imfilter(double(mtx_map), G, 'same', 'conv');
    
    % threshold map into binary mtx
    mtx_map = (mtx_map >= 0.2);
    processed_map = binaryOccupancyMap(mtx_map);
end

function map = occupancy_map(map, x, y, theta, ang_vel, flag, ranges)

    flag = 1;


    if abs(ang_vel) > 0.3
        return;
    end

    angles = linspace(0, 2*pi, 360);

    % offset so start is at the center of the map
    offset = 7.5; % half of map_size
    x = x + offset;
    y = y + offset;
    



    x_lidar = ranges .* cos(angles');
    y_lidar = ranges .* sin(angles');
    
    % min max filtering
    valid = (0.2 <= ranges) & (ranges <= 3);
    ranges = ranges(valid);
    angles = angles(valid);

    x_lidar = x_lidar(valid);
    y_lidar = y_lidar(valid);

    R = rot2(theta);
  
    % rotate w.r.t offset
    lidar_world = [x_lidar'; y_lidar'] - [-offset; -offset];
    lidar_world = R*lidar_world;
    lidar_world = lidar_world + [x + offset; y + offset];
    
    for i = 1:size(lidar_world, 2)       
       x_vals = lidar_world(:, 1);
       y_vals = lidar_world(:, 2);

       setOccupancy(map, [x_vals y_vals], 1);
    end

    insertRay(map, [x, y, theta], ranges, angles, 3.5);
    show(map);
    hold on
    %scatter(x, y, 100, 'rx')

   
end
