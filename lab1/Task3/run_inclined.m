clear all
close all
clc
%% set up the enviroment
lim = [-2.0, 2.0, -2.0, 2.0, -2.0, 2.0]; % to define the limit of x,y,z
mdl_puma560     % to load the puma560 robot
p560.plot(qz,'workspace',lim)   % to draw the robot

% to define and to plot a wall 
a = cos(deg2rad(10));  % the wall is defined as ax+by+cz+d = 0 
b = 0;
c = sin(deg2rad(10));
d = -cos(deg2rad(10));
wall = Wall(a,b,c,d,lim);  % to define the wall
wall.plotwall();           % to plot the wall

%% place your trajectory generation code here
% 1) An example trajectory can be loaded from the 'q.mat' file

h = [
0 1    0
0 0    0
0 0.5  0
0 0.5  0.5
0 1    0.5 
0 0    0.5 
].*0.3 * rotx(-pi/2);

t = [ % transition between last point in h and first in k, x =/= 0 in order to not draw this
0 0 0.5
-0.1 0.5 0.75
0 1 1
].*0.3 * rotx(-pi/2);

k = [
0 1   1
0 0   1
0 0.5 1
0 1   1.5
0 0.5 1
0 0   1.5
] * 0.3*rotx(-pi/2);

% to draw on the incline wall we simply rotate along the y axis 10 degrees
h=h*roty(10, 'deg');
t=t*roty(10, 'deg');
k=k*roty(10, 'deg')
h_traj = mstraj(h, [0.1, 0.1, 0.1], [], h(1,:), 0.2, 0);
t_traj = mstraj(t, [0.1, 0.1, 0.1], [], t(1,:), 0.2, 0);
k_traj = mstraj(k, [0.1, 0.1, 0.1], [], k(1,:), 0.2, 0);

%load q_inclined.mat
%traj=q;

%% send to robot
Tp =SE3(0.6, 0, 0) *   SE3([h_traj;t_traj;k_traj]) * SE3.oa( [0 1 0], [1 0 0.1]);
q = p560.ikine6s(Tp);
plot_qtraj(q, wall, p560)