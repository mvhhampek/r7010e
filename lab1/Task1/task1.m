close all
clear
clc



via = [
  0, 0, 0, 0, 0, 0  
  0, 0, 1, 0, pi/2, 0
  1, 0, 1, 0, -pi, 0
  1, 0, -0.5, 0, pi/2, 0
];

poses2 = repmat(SE3(), 1, 4); 

for i = 1:4
    position = via(i, 1:3);
    rpy = via(i, 4:6);
    % add posiotion and orientation to pose objects
    poses2(i) = SE3(position) * SE3.rpy(rpy(1), rpy(2), rpy(3));
end

vel = 1;
traj = mstraj(via, [vel,vel,vel,vel,vel,vel], [], via(1,:), 0.1, 2);

num_poses = size(traj, 1);
% make list of empty se3 object
poses = repmat(SE3(), 1, num_poses); 


for i = 1:num_poses
    position = traj(i, 1:3);
    rpy = traj(i, 4:6);
    % add posiotion and orientation to pose objects
    poses(i) = SE3(position) * SE3.rpy(rpy(1), rpy(2), rpy(3));
end
%%
figure
hold on
grid on
axis equal
xlabel('X'); ylabel('Y'); zlabel('Z');
view(3);
xlim([-0.5, 1.5]);
ylim([-0.5, .5]);
zlim([-1, 1.5]);
plot3(traj(:, 1), traj(:, 2), traj(:, 3), 'black--', 'LineWidth', 0.5);

axis_length = 0.5; 
frame = [];

% A,B,C,D poses...
for i = 1:4
    trplot(poses2(i), 'length', axis_length/2, 'arrow', 'rgb')
end

% draw each pose in the trajectory
for i = 1:num_poses
    % removes the previous frame
    if ~isempty(frame)
        delete(frame);
    end
    
    frame = trplot(poses(i), 'length', axis_length, 'arrow', 'rgb');% 'rvis');

    pause(0.05)
end

