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

path=[ p_init;...  % times door with [10, 10]
       15 30 ;...
       15 60 ;...
       50 60 ;...
       50 95 ;...
       70 95 ;...
       70 60 ;...
       80 60 ;...
       90 60 ;...
       90  3 ;...
       20  3 ;...
       p_goal
];
%% Genrate trajectory
QDMAX=[10,10]; %axis speed limits
DT=0.2;
Q0= path(1,:); %initial axis coordinates
t_acc = 1;
[traj, t_segments] = mstraj(path, QDMAX, [], Q0, DT, t_acc);



door_coords = [90, 50];
index = index_of_closest_point(traj, door_coords);
time_to_point = t_segments(index);

% door is open 0-5, 10-15 etc, closed 5-10, 15-20 etc
is_open_on_arrival = mod(floor(time_to_point / 5), 2) == 0


%% Plot the path
hold on
plot(traj(:,1), traj(:,2), '-r')
obstacle=1; %0 when there is no door to block the way, 1 the door will be on
hold on
animatepath(traj,DT,obstacle)


function index = index_of_closest_point(traj, target_point)
    [is_found, index] = ismember(target_point, traj, 'rows');
    if is_found == 0
        distances = sqrt(sum((traj - target_point).^2, 2));
        [~, index] = min(distances);
    end
end
