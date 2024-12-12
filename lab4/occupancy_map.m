function flag = occupancy_map(x, y, theta, flag, ranges)
    global map
    
    if flag == 0 
       map_size = [15, 15]; 
       map_res = 10;
       map = occupancyMap(map_size(1), map_size(2), map_res);
    end
    offset = 7.5;
    x = x + offset;
    y = y + offset;
    flag = 1;
    angles = linspace(0, 2*pi, 360);
    
    valid = (0.2 <= ranges) & (ranges <= 3.4);
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