close all
clear all
clc
%%
ptCloud = pcread('fountain.ply');
pcshow(ptCloud,ColorSource='Z')
% Fix Styling
xlabel("X")
ylabel("Y")
zlabel("Z")
set(gca,'color','w');
set(gcf,'color','w');
set(gca, 'XColor', [0.15 0.15 0.15], 'YColor', [0.15 0.15 0.15], 'ZColor', [0.15 0.15 0.15])
axis on



radius = 7;
theta = pi/2;
d_theta = pi/6;
z = 1;
d_z = 1/3;
via = [];
while z < 17
    via = [via; radius*cos(theta), radius*sin(theta), z];
    z = z + d_z;
    theta = theta + d_theta;
end

for i = 1:25
    via = [via; radius*cos(theta), radius*sin(theta), z];
    theta = theta + d_theta;
    radius = radius - 0.2;
end

traj = mstraj(via, [1, 1, 1], [], via(1,:), 0.2, 2);
hold on
plot3(traj(:,1), traj(:,2), traj(:,3), 'black-', 'LineWidth', 2)