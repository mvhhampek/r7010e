clf
idx = 10;
ranges2 = ranges.Data(idx,:);
x_robot = x.Data(idx);
y_robot = y.Data(idx);
theta_robot = theta.Data(idx);
% hogir vägg
R = ranges2(240:299);
angles = linspace(0, 2*pi, 360);
A = angles(240:299);

offset = -0.5;

avg_R = mean(reshape(R, 15, []), 1);
avg_A = mean(reshape(A, 15, []), 1);
[avg_x, avg_y] = pol2cart(avg_A, avg_R);
warning('off', 'all')
coeffs = polyfit(avg_x, avg_y, 1);
warning('on', 'all')
a = -coeffs(1);
b = 1;
c = -coeffs(2);

c_offset = c+offset*sqrt(a^2 + b^2);




e = abs(a*x0 + b*y0 + c_offset) / sqrt(a^2 + b^2);

theta_star = atan2(-a, b);
x_star = avg_x(end);
y_star = avg_y(end);
%theta_star = atan2((y_star - y_robot), (x_robot - x0));

output = [e; theta_star];

x_line = linspace(-3, 3, 100) + 1;
y_line = -(a/b)*x_line -(c_offset/b);

x_line = x_line;

[x_lid, y_lid]=pol2cart(angles, ranges2);

scatter(x_robot, y_robot, 'bo')
hold on
robot_o_x = x_robot + 0.5*cos(theta_robot);
robot_o_y = y_robot + 0.5*sin(theta_robot);
robot_c_x = x_robot + 0.5*cos(theta_star);
robot_c_y = y_robot + 0.5*sin(theta_star);


%plot(x_line, y_line)
hold on 
scatter(x_lid, y_lid, 'yx')
hold on
scatter(avg_x, avg_y, 'rx')
hold on 
plot([x_robot robot_o_x], [y_robot robot_o_y], 'blue-')
hold on 
plot([x_robot robot_c_x], [y_robot robot_c_y], 'black-')
hold on


transf = ([avg_x; avg_y]' * rot2(theta_star) + [1, -offset])*rot2(-theta_star) 
x_starr = transf(end, 1)
y_starr = transf(end, 2)
scatter(transf(:,1), transf(:,2),10, 'blacko')
hold on
scatter(x_starr, y_starr,100, 'redx')
xlim([-3, 3])
ylim([-3, 3])

