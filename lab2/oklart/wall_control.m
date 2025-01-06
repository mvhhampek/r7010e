function output = wall_control(x0, y0, offset, theta, ranges)
    angles = linspace(0, 2*pi, numel(ranges));
    
    R = ranges(240:299);
    A = angles(240:299);
    
    avg_R = mean(reshape(R, 5, []), 1);
    avg_A = mean(reshape(A, 5, []), 1);
    [avg_x, avg_y] = pol2cart(avg_A, avg_R);
    warning('off', 'all')
    coeffs = polyfit(avg_x, avg_y, 1);
    warning('on', 'all')
    a = -coeffs(1);
    b = 1;
    c = -coeffs(2);
    
    % rotate to get world frame, move points offset in y to accomodate wall,
    % move 1 in x to make "goal point" straight forward 
    theta_star = atan2(-a, b);
    transf = ([avg_x; avg_y]' * rot2(theta_star) + [1, offset])*rot2(-theta_star); 
    x_star = transf(end, 1);
    y_star = transf(end, 2);

    %c_offset = c+offset*sqrt(a^2 + b^2);
    e = sqrt((x_star - x0)^2 + (y_star - y0)^2);

    output = [e; theta_star];

    scatter(avg_x, avg_y, 20, 'rx')
    hold on
    scatter(x0, y0, 100, 'bo')
    hold on 
    scatter(x_star, y_star, 100, 'rx')
    hold off

    xlim([-2, 2])
    ylim([-2, 2])
end