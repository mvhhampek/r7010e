close all
clear all
clc
load('Points10.mat') %All
X=X/10;
Y=Y/10;
Z=Z/10;        
xyz=[X Y Z];
plot3(X,Y,Z);
grid on
box on
axis equal

xlabel('x')
ylabel('y')
zlabel('z')


base_radius = 7;
theta = pi/2;
d_theta = pi/6;
d_z = 1/3;
z = 1;
base_via = [];
while z < 38
    base_via = [base_via; base_radius*cos(theta) base_radius*sin(theta) z];
    z = z + d_z;
    theta = theta + d_theta;
    base_radius = base_radius - 0.025;
end


blade_radius = 5;
y_offset = -5;
z = 45;
blade_via = [];
theta = pi;

% using y_offset and z from 45 to 70 instead of translating it after
while z < 70
    blade_via = [blade_via; blade_radius*cos(theta) blade_radius*sin(theta)+y_offset z];
    z = z + d_z;
    theta = theta + d_theta;
    blade_radius = blade_radius - 0.015;
end

% translate so origin is the line z=40, x=0
blade_via2 = blade_via - [0 0 40];

blade_via2 = blade_via2*roty(-2*pi/3); % rotate 
blade_via3 = blade_via2*roty(-2*pi/3); % rotate 

blade_via2 = blade_via2 + [0 0 40]; % translate back to normal frame
blade_via3 = blade_via3 + [0 0 40];

hold on
vias = [base_via;blade_via;blade_via2;blade_via3];
traj = mstraj(vias, [1, 1, 1], [], vias(1,:), 0.2, 1);
plot3(traj(:,1), traj(:,2), traj(:,3), 'black-', 'Linewidth', 2)



