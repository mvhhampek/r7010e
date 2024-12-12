function [a,b,c] = wall_traj(ranges, angles)
        
    % hogir vägg
    R = ranges(329:270);
    A = angles(329:270);
    
    avg_R = mean(reshape(R, 10, []), 1);
    avg_A = mean(reshape(A, 10, []), 1);
    [avg_x, avg_y] = pol2cart(avg_A, avg_R);
    warning('off', 'all')
    coeffs = polyfit(avg_x, avg_y, 1);
    warning('on', 'all')
    a = -coeffs(1);
    b = 1;
    c = -coeffs(2);

end


