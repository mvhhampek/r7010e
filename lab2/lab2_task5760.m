clc
figure(1)
ranges = simout.data(1,:);
angles = linspace(0, 2*pi, numel(ranges));
polarplot(angles, ranges)
hold on 
%polarplot(angles(270:340), ranges(270:340), 'rx')
R = ranges(270:339);
A = angles(270:339);
theta = angles(270);
r = ranges(270);
avg_R = mean(reshape(R, 10, []), 1);
avg_A = mean(reshape(A, 10, []), 1);
[avg_x, avg_y] = pol2cart(avg_A, avg_R);

points_R = [avg_x;avg_y]'*rot2(-90,'deg')

hold on
polarplot(avg_A, avg_R, 'rx')
[x,y] = pol2cart(theta, r);
hold off
figure(2)
scatter(points_R(:,1), points_R(:,2), 'rx')

% robot vinkel:
theta = 0;
robot_x = 5;
robot_y = 6;
dist_to_wall = 0.5;


T = [rot2(theta) [robot_x; robot_y]; 0 0 1];
points_R = [points_R, ones(size(points_R, 1), 1)];
figure(3)
points_W = (T*points_R')'
points_W_t = points_W + [-dist_to_wall 0 0];

plot(points_W(:,1), points_W(:,2), 'rx')
hold on
plot(points_W_t(:,1), points_W(:,2), 'bx')
xlim([0, 7])
ylim([0, 7])
    points = [
        points_W_t(3,1), points_W_t(3,2)
        %points(4,1), points(4,2)
    ]
%x = x + current_x
%y = y + current_y