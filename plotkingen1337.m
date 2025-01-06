clf
square = [
  0 0 0
  1 0 0
  1 1 0
  0 1 0
  0 0 0
];
K = [
         0         0
    0.0000    1.0000
    0.0000    0.5000
    0.5000    1.0000
    0.0000    0.5000
    0.5000   -0.0000
    0.0000    0.5000
         0         0
].*1.5;
K = [K [pi/2 -pi/2 pi/4 -3*pi/4 -pi/4 3*pi/4 -pi/2 pi/2]'];
K = mstraj(K, [1, 1, 1], [], [0,0,0], 1, 0);



clf
x = linspace(0,2*pi, 20);
y = 5*sin(x).*1/(2*pi);
x = 2*x.*1/(2*pi);
sinussy = [x' y'];
traj=sinussy;
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
plot(x, y, 'r--')

hold on 
x_ = x_exp.Data;
y_ = y_exp.Data;
yaw_ = theta_exp.Data;
plot(x_, y_, 'b-', 'LineWidth', 1)


hold on
axis equal


xlabel('X')
ylabel('Y')
%xlim([-1.2 1.7])
%ylim([-0.2 2.7])
legend('Reference Line', 'Robot Position')