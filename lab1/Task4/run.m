clear all
clc
close all
addpath(genpath('./'));
%%
% map1.txt and map2.txt are the complex enviroments
map = load_map('maps/map1.txt', 0.1, 2, 0.25);
plot_path(map);
grid on
box on

via_1 = [
-5 2 0
-5 2 5
2 2 5 
2 2 0 
5 2 0 
5 2 5 
8.5 2 5
8.5 2 0 
11 2 0
11 2 5
14.5 2 5 
14.5 2 0
17 2 0
17 2 5
22 2 5
22 2 0
];
traj_1 = mstraj(via_1, [1, 1, 1], [], via_1(1,:), 0.2, 1);
hold on
plot3(traj_1(:,1), traj_1(:,2), traj_1(:,3), '-')
%%
map = load_map('maps/map2.txt', 0.1, 2, 0.25);
plot_path(map);
grid on
box on

via_2 = [
5 1 0
5 1.5 2
5 17 4.5
5 20 2
];
traj_2 = mstraj(via_2, [1, 1, 1], [], via_2(1,:), 0.2, 1);
hold on
plot3(traj_2(:,1), traj_2(:,2), traj_2(:,3), '-')
