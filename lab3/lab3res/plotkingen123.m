square = [
    0 4 1 pi/2
    0 5 1 2*pi
    1 5 1 3*pi/2
    1 4 1 -pi
    0 4 1 pi/2
];
j = 4;
for i  = 2:size(square, 1)
    diff = square(i,j) - square(i-1, j);
    while diff > pi
        diff = diff -2*pi;
    end
    while diff < -pi
        diff = diff +2*pi;
    end
    square(i,j)=square(i-1,j)+diff;
end
traj  = mstraj(square, [0.3, 0.3, 0.3, 0.3], [], square(1,:,:), 1, 1);
x_ref = traj(:, 1);
y_ref = traj(:, 2);
z_ref = traj(:, 3);
yaw_ref = traj(:, 4);
%%
theta = linspace(0, 2*pi, 20);

x_ref = 0.5*sin(theta);
y_ref = 0.5*cos(theta)+3.5;
z_ref = ones(1, length(x_ref));

yaw_ref = atan2(-y, -x);

%% TILTED CIRCLE
theta = linspace(0, 2*pi, 20);

x_ = 0.5*sin(theta);
y_ = 0.5*cos(theta);
z_ = ones(1, length(x));

yaw_ref = atan2(-y, -x);

pos = [x_' y_' z_']*rotx(45, 'deg');
x_ref = pos(:, 1);
y_ref = pos(:, 2)+3.5;
z_ref = pos(:, 3)+0.5;

%%
%x = xxx.Data;
%y = yyy.Data;
%z = zzz.Data;
%yaw = yawww.Data;

figure
grid on
axis equal
xlabel('X'); ylabel('Y'); zlabel('Z');
%xlim([-1.5, 1.5]);
%ylim([3, 6]);
%zlim([0.5, 2]);

view(45, 30);
plot3(x_ref, y_ref, z_ref, 'b--')
hold on
plot3(x, y, z, 'r-')
