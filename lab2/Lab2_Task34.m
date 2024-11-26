square = [
  0 0 0
  1 0 0
  1 1 0
  0 1 0
];


K = [
0 0 0
1 0 0
0.5 0 0 
1 -1 0
0.5 0 0 
0 -1 0
0.5 0 0
];

x = linspace(0, 2*pi, 15);
y = sin(x).*1/(2*pi);
x = x.*1/(2*pi);

sinussy = [x' y'];


traj = square;

x = traj(:,1)
y = traj(:,2)
%plot(x, y)
%%


%a, b, c = 1, -1, 1
% a, b, c = 1, -2, 4
%%
a=1;
b=-1;
c=1;
%%
a=1;
b=-2;
c=4;
%%
a = a + c;

x = linspace(0, 2, 10);


y = -(a*x) / b;


scatter(x , y)

traj = [x' y']