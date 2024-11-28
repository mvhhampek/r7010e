clear
clc
close all

theta = linspace(0, 2*pi, 50);

x = sin(theta);
y = cos(theta);
z = 1;

yaw = atan2(-y, -x);
%%
figure
hold on
grid on
axis equal
xlabel('X'); ylabel('Y'); zlabel('Z');
xlim([-2, 2]);
ylim([-2, 2]);
zlim([ 0, 2]);
view(45, 30);
frame = [];
for C = 1:100000
    i = mod(C-1, 50) + 1;
    pose = SE3(x(i),y(i),z) * SE3.rpy(0, 0, yaw(i));

    if ~isempty(frame)
        delete(frame);
    end
    
    frame = trplot(pose, 'length', 0.5);
    
    pause(0.05)

end