
plot(x_exp.Data, y_exp.Data, 'r-')
hold on
goal = [3, -0.5, -pi/2];
scatter(goal(1), goal(2), 50,'bo')
hold on
draw_arrow(goal(1), goal(2), goal(3), 0.1, 'b')
hold on
draw_arrow(x_exp.Data(end),y_exp.Data(end),theta_exp.Data(end), 0.1, 'r')





function draw_arrow(x0, y0, ang, length, color_)
    dx = length*cos(ang);
    dy = length*sin(ang);
    quiver(x0,y0,dx,dy,0,'MaxHeadSize',0.5,'Color', color_)
end