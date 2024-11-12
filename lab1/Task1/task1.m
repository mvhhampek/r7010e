%% 
clear all
clf
close all
%% 
A_pose = {0, 0, 0, 0, 0, 0};
B_pose = {0, 0, 1, 0, pi/2, 0};
C_pose = {1, 0, 1, 0, -pi, 0};
D_pose = {1, 0, -0.5, 0, pi/2, 0};

A = pose2mtx(A_pose{:});
B = pose2mtx(B_pose{:});
C = pose2mtx(C_pose{:});
D = pose2mtx(D_pose{:});

%trplot(D, 'frame', 'D', 'arrow', 'rgb'); 
mtxs = {A,B,C,D};
names = {'A','B','C','D'};

%%
vias = [
    A_pose{1:3}
    B_pose{1:3}
    C_pose{1:3}
    D_pose{1:3}
];
QDMAX = [1,1,1];
time_step = 0.05;
t_acc = 1;
q = mstraj(vias, QDMAX, [], vias(1,:), time_step, t_acc);
plot3(q(:,1), q(:,2), q(:,3), '-')
grid on
title('trajectory')
xlabel('x')
ylabel('y')
zlabel('z')
hold on
%%

A = SE3([A_pose{1:3}]) * SE3.rpy(A_pose{4:6});              
B = SE3([B_pose{1:3}]) * SE3.rpy(B_pose{4:6});  
C = SE3([C_pose{1:3}]) * SE3.rpy(C_pose{4:6});  
D = SE3([D_pose{1:3}]) * SE3.rpy(D_pose{4:6});  

AB = ctraj(A, B, 50); 
BC = ctraj(B, C, 50); 
CD = ctraj(C, D, 50); 
T = [AB;BC;CD];
trplot(A, 'color', 'b'); 
pause(3);
hold off
T.animate
%AB.animate
%BC.animate
%CD.animate



%%
% returns homogenous transformation matrix of the pose 
function mtx = pose2mtx(x,y,z,r,p,y2)
    % ZYX seq
    R = rotz(y2, 'rad') * roty(p, 'rad') * rotx(r, 'rad'); 
    % make homogenous transformation matrix
    mtx = [R, [x,y,z]'; 0,0,0,1];
end 
