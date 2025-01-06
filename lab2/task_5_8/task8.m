ranges = ranges_exp.Data;
x= x_exp.Data;
y= y_exp.Data;
yaw = theta_exp.Data;

% använd task 12 simulink filen 
%% 
% discard values that have been saturated, they are likely noise :)
ranges(ranges <= 0.12) = 100;
ranges(ranges >= 3.5) = 100;

clf
clc
close all
figure
angles = linspace(0, 2*pi, 360);
n = length(x);
map_x = [];
map_y = [];
x_local = ranges.* cos(angles);
y_local = ranges.* sin(angles); 



x_global = zeros(size(x_local));
y_global = zeros(size(x_local));

% varför i helvete är yaw en 1 x 1 x n double??? ingen vet mannen tack
% matlab :thumbs_up:
yaw(isnan(yaw)) = 0;
R = rot2(yaw(1,:,:));


for i = 1:size(x_local, 1)
    Ri = R(:,:,i);
    
    local_points = [x_local(i,:)' y_local(i,:)']';
    
    global_points = Ri*local_points;

    x_global(i, :) = x(i) + global_points(1,:);
    y_global(i, :) = y(i) + global_points(2,:);

end




xlabel('X')
ylabel('Y')
hold on
scatter(x_global(:), y_global(:), 10, 'bo')
hold on
plot(x, y, 'r-', 'LineWidth', 2)
xlim([-2.5 8.5])
ylim([-4 5])
legend('Lidar Readings', 'Robot Trajectory')