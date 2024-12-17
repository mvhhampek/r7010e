%%
load('linus_karlsson_vanortsvägen38.mat')
%%
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
map = binaryOccupancyMap(map_size, map_size, map_res);

for i = 1:n
    ranges = ranges_vals(i, :);
    x = x_vals(i);
    y = y_vals(i);
    theta = theta_vals(i);
    ang_vel = ang_vel_vals(i);
    occupancy_map(map, x, y, theta, ang_vel, i-1, ranges');
end
disp('donezo')
show(map);
%%
show(post_process_map(map))
%%
figure
processed_map = post_process_map(map);
mtx_map = occupancyMatrix(processed_map);
ds = Dstar(mtx_map, 'inflate', 5);
start = [150, 150];
goal = [240, 150];
ds.plan(goal);
path = ds.query(start);
ds.plot(path)


%%
figure
irl_path = path_to_irl(path, 20, 15);
plot(irl_path(:,1), irl_path(:,2), 'ro')
axis equal

%%
function irl_path = get_path(goal, map, map_res, map_size, x, y)
    x = x*map_res + map_size*10;
    y = y*map_res + map_size*10;
    

    ds = Dstar(map, 'inflate', 3);
    start = [x, y];
    ds.plan(goal);
    path = ds.query(start);
    irl_path = path_to_irl(path, map_res, map_size);
end
function irl_path = path_to_irl(path, map_res, map_size)
    path = path - map_size*10;
    irl_path = path/map_res;
end
function processed_map = post_process_map(map)
    mtx_map = occupancyMatrix(map);
    G = fspecial('gaussian', [5 5], 1);
    mtx_map = imfilter(double(mtx_map), G, 'same', 'conv');
    
    % threshold map into binary mtx
    mtx_map = (mtx_map >= 0.25);

    processed_map = binaryOccupancyMap(mtx_map);
end
%%
function map = init_map(map_size, map_res, flag)
    if flag == 1
        map = binaryOccupancyMap(map_size, map_size, map_res);
        flag = 0;
        output = [map; flag];
    else
        output = [map;flag];
        return;
    end
    
end
%%
% turn slower or map only when not turning
function map = occupancy_map(map, x, y, theta, ang_vel, flag, ranges)
    %global map
    
    %if flag == 0 
    %   map_size = [15, 15]; 
    %   map_res = 20;
    %   map = occupancyMap(map_size(1), map_size(2), map_res);
    %end
    flag = 1;


    if abs(ang_vel) > 0.3
        return;
    end

    angles = linspace(0, 2*pi, 360);

    % offset so start is at the center of the map
    offset = 7.5;
    x = x + offset;
    y = y + offset;
    

    idxs = 1:360;
    range = -2:2;
    wrapped_idxs =  mod((idxs(:) + range - 1), 360) + 1;

    x_ = ranges .* cos(angles');
    y_ = ranges .* sin(angles');
    
    x_diff = x_ - x_(wrapped_idxs);
    y_diff = y_ - y_(wrapped_idxs); 

    dists = sqrt(x_diff.^2 + y_diff.^2);
    ranges(mean(dists, 2) > 0.15) = 100;
    



    
    % min max filtering
    valid = (0.2 <= ranges) & (ranges <= 3);
    ranges = ranges(valid);
    angles = angles(valid);

    x_lidar = x_(valid);
    y_lidar = y_(valid);

    R = rot2(theta);
  
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
    scatter(x, y, 100, 'rx')

   
end
