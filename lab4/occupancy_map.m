function flag = occupancy_map(x, y, theta, ang_vel, flag, ranges)
    global map
    
    if flag == 0 
       map_size = [15, 15]; 
       map_res = 20;
       map = occupancyMap(map_size(1), map_size(2), map_res);
    end
    flag = 1;


    if abs(ang_vel) > 0.3
        return;
    end

    angles = linspace(0, 2*pi, 360);

    % offset so start is at the center of the map
    offset = 7.5;
    x = x + offset;
    y = y + offset;
    
    %idxs = 1:360;
    %range = -2:2;
    %wrapped_idxs =  mod((idxs(:) + range - 1), 360) + 1;

    %x_ = ranges .* cos(angles');
    %y_ = ranges .* sin(angles');
    
    %x_diff = x_ - x_(wrapped_idxs);
    %y_diff = y_ - y_(wrapped_idxs); 

    %dists = sqrt(x_diff.^2 + y_diff.^2);
    %ranges(mean(dists, 2) > 1) = 100;


    
    % min max filtering
    valid = (0.2 <= ranges) & (ranges <= 3);
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