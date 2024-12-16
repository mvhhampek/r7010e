clear
clc
close all
%% SQUARE LOOKING TOWARDS NEXT POINT 
square = [
    0 0 1 pi/2
    0 1 1 2*pi
    1 1 1 3*pi/2
    1 0 1 -pi
];
x = square(:, 1);
y = square(:, 2);
z = square(:, 3);
yaw = square(:, 4);

%% CIRCLE LOOKING TOWARDS CENTER
theta = linspace(0, 2*pi, 50);

x = sin(theta);
y = cos(theta);
z = ones(1, length(x));

yaw = atan2(-y, -x) + pi/2;

%% TILTED CIRCLE
pos = [x' y' z']*rotx(45, 'deg');
x = pos(:, 1);
y = pos(:, 2);
z = pos(:, 3);


%%
figure
hold on
grid on
axis equal
xlabel('X'); ylabel('Y'); zlabel('Z');
xlim([-2, 2]);
ylim([-2, 2]);
zlim([ 0, 2]);

%view(45, 30); % normal
view(135, 30); % tilted
frame = [];
plot3(x, y, z, 'black--', 'LineWidth', 0.5);

for C = 1:1000
    i = mod(C-1, length(x)) + 1;
    pose = SE3(x(i),y(i),z(i)) * SE3.rpy(0, 0, yaw(i));

    if ~isempty(frame)
        delete(frame);
    end
    
    frame = trplot(pose, 'length', 0.3);
    
    pause(0.05)

end