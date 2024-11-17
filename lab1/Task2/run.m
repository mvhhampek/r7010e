%% clear the workspace variables and close all figures
clear all
clc
close all
%% Load the map
load map1
about map
%% plot the map
plot(Bug2(map))
%% Initial position and heading of the robot
p_init=[50 30]; % [x,y]
%% Goal location of the robot 
p_goal=[20 5]; % [x,y]

%% Define the desired path 

path=[
    p_init
    15 30
    15 60
    50 60
    50 95
    90 95
    90 60
    90 40
    90 1
    p_goal
];

% time it takes to get to each point
t_seg = [0.1,2.9,3,3,3,3,5,2,3,3];
%% Genrate trajectory
traj = mstraj(path, [], t_seg, path(1,:), 0.2, 1);


%% Plot the path
hold on
plot(traj(:,1), traj(:,2), '-r')
plot(path(:,1), path(:,2), 'rx')
obstacle=1; %0 when there is no door to block the way, 1 the door will be on
hold on
animatepath(traj,DT,obstacle)
