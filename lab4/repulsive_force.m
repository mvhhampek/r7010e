function Fr = repulsive_force(r_influence, L, ranges)
    angles = linspace(0, 2*pi, length(ranges));
    
    Fr_X = 0;
    Fr_Y = 0;
    for i = 1:length(ranges)
        rho = ranges(i);
        theta = angles(i);
        if rho > 0.12 % min_distance from lidar
            if rho < r_influence
                F_mag = L * (1 - (rho / r_influence))^2;
                Fr_X = Fr_X + F_mag * -cos(theta);
                Fr_Y = Fr_Y + F_mag * -sin(theta);
            end
        end
    end
    Fr = [Fr_X; Fr_Y];
end