clc

lidar_data = simout.data;
num_beams = 128;

angle_min = 0;
angle_max = 6.266;
range_min = 0.12;
range_max = 3.5;

angle_inc = (angle_max) / 127;
angles = angle_min:angle_inc:angle_max;
polarplot(angles, lidar_data)

%plot()
%%
% 
for i = 1:100
    ranges = simout.data(i,:);
    angles = linspace(0, 2*pi, length(ranges));
    scan = lidarScan(ranges, angles);

    hold on
    plot(scan)
end



%scan2 = removeInvalidData(scan, 'RangeLimits', [range_min, range_max]);

%polarplot(ang
% , rng)
%polarplot(angles, simout.data(:,37));
%plot(scan);


