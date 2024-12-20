close all
clear
clc

via = [
  0, 0, 0, 0, 0, 0  % A
  0, 0, 1, 0, pi/2, 0 % B
  1, 0, 1, 0, -pi, 0 % C
  1, 0, -0.5, 0, pi/2, 0 % D
];

% to draw the 4 poses
poses2 = repmat(SE3(), 1, 4); 
for i = 1:4
    position = via(i, 1:3);
    rpy = via(i, 4:6);
    % add posiotion and orientation to pose objects
    poses2(i) = SE3(position) * SE3.rpy(rpy(1), rpy(2), rpy(3));
end

%%
j = 5;
for i = 2:size(via, 1)
    diff = via(i, j) - via(i-1, j);
    % map difference to [-pi, pi]
    while diff > pi
        diff = diff - 2*pi;
    end
    while diff < -pi
        diff = diff + 2*pi;
    end
    via(i, j) = via(i-1, j) + diff;
end


traj = mstraj(via, [1,1,1,1,1,1], [], via(1,:), 0.1, 2);
%%



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
h = figure;
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
%for i = 1:4
%    trplot(poses2(i), 'length', axis_length/2, 'arrow', 'rgb');
%end

% draw each pose in the trajectory
for i = 1:num_poses
    % removes the previous frame
    if ~isempty(frame)
        delete(frame);
    end
    
    frame = trplot(poses(i), 'length', axis_length, 'arrow', 'rgb');


    % save as gif...
    %frame_image = getframe(h);
    %im = frame2im(frame_image); 
    %[imind, cm] = rgb2ind(im, 256); 
    %if i == 1
    %    imwrite(imind, cm, '123123.gif', 'gif', 'Loopcount', inf, 'DelayTime', 0.05);
    %else
    %    imwrite(imind, cm, '123123.gif', 'gif', 'WriteMode', 'append', 'DelayTime', 0.05);
    %end
    pause(0.05)
end

