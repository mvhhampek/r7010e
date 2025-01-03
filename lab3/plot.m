load("lab3/lab3res/tilted_circle_traj.mat")
%%
x_ref = out.x_ref_fixed.Data;
y_ref = out.y_ref_fixed.Data;
z_ref = out.z_ref_fixed.Data;
%%
x = x.Data;
y = y.Data;
z = z.Data;
yaw = yaw.Data;
x_ref = x_ref.Data;
y_ref = y_ref.Data;
z_ref = z_ref.Data;
yaw_ref = yaw_ref.Data;

%% to simulate run data to fix reference trajectory 
dt = 0.1;
time = (0:dt:(length(x)-1)*dt)'; 
x = timeseries(x, time);
y = timeseries(y, time);
z = timeseries(z, time);
yaw = timeseries(yaw, time);
%%
close all


figure
plot3(x_ref, y_ref, z_ref, 'r--')
hold on 
plot3(x,y,z, 'b-')
legend('Reference Position','Actual Position','Location','Best')
grid on


figure
plot(ones(size(z)), 'r--')
hold on 
plot(z, 'b-')
legend('Reference Height','Actual Height','Location','Best')
grid on



figure 
plot(x_ref, y_ref, 'r--')
hold on
plot(x, y, 'b-')
legend('Reference Position','Actual Position','Location','Best')
grid on
axis equal

