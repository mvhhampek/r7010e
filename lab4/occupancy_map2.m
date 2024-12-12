%%
ranges_vals = ranges_exp.Data;
x_vals = x_exp.Data;
y_vals = y_exp.Data;
theta_vals = theta_exp.Data;
n = length(x_vals);
angles = linspace(0, 2*pi, 360);
%%
for i = 1:n
    ranges = ranges_vals(i, :);
    x = x_vals(i);
    y = y_vals(i);
    theta = theta_vals(i);
    occupancy_map(x, y, theta, i-1, ranges');

end


%%
% turn slower or map only when not turning
function flag = occupancy_map(x, y, theta, flag, ranges)
    global map
    
    if flag == 0 
       map_size = [15, 15]; 
       map_res = 10;
       map = occupancyMap(map_size(1), map_size(2), map_res);
    end
    flag = 1;
    angles = linspace(0, 2*pi, 360);

    % offset so start is at the center of the map
    offset = 7.5;
    x = x + offset;
    y = y + offset;
    
    region_size = 10;
    for i = 1:36
        start_idx = (i-1)*region_size + 1;
        end_idx = min(i*region_size, 360);
        
        region = ranges(start_idx : end_idx);
        region_median = median(region);
        dev = abs(region - region_median) / region_median;

        % deviation threshold = 0.2
        outliers = dev > 0.2;
        region(outliers) = 100;
        ranges(start_idx : end_idx) = region;
    end


    
    % min max filtering
    valid = (0.2 <= ranges) & (ranges <= 2);
    ranges = ranges(valid);
    angles = angles(valid);

    x_lidar = ranges.*cos(angles');
    y_lidar = ranges.*sin(angles');

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
    scatter(x, y, 'rx')

   
end