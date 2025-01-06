square = [
  0 0 0
  1 0 0
  1 1 0
  0 1 0
  0 0 0
];
square = mstraj(square, [1, 1, 1], [], [0,0,0], 0.1, 0.1);

traj = square(2:end-1, :, :);
x = traj(:,1);
y = traj(:,2);
yaw = zeros(size(x));
%%
K = [
         0         0 0
    0.0000    1.0000 0
    0.0000    0.5000 0
    0.5000    1.0000 0
    0.0000    0.5000 0
    0.5000    0.0000 0
    0.0000    0.5000 0
         0         0 0
].*1.5


L = [0 0 0
    1 0 0 
    1 1 0
    ];
L = mstraj(L, [1, 1, 1], [], [0,0,0], 0.3, 0.5);


K = mstraj(K, [1, 1, 1], [], [0,0,0], 1, 1);

traj = K;
x   = traj(:,1);
y   = traj(:,2);
yaw = traj(:,3);
%%
x = linspace(0,2*pi, 50);
y = 3*sin(x).*1/(2*pi);
x = 2*x.*1/(2*pi);
sinussy = [0 0; (x+0.2)' y'];
x = sinussy(:,1);
y = sinussy(:,2);
yaw = zeros(size(x));
%% PLOT TRAJECTORY
close all
plot(x, y, 'b--')
hold on
plot(x_exp.Data, y_exp.Data, 'r-')



%% PLOT LINE
%%
a = 1;
b = -1;
c = 1;
%%
a = 1;
b = -2;
c = 4;
%%
x = linspace(-10, 5, 100);
y = -(a/b)*x- (c/ b);

close all
plot(x, y, 'b--')
hold on 
plot(x_exp.Data, y_exp.Data, 'r-')
