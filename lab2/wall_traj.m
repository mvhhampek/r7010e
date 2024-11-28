function points = wall_traj(on_goal, dist_to_wall,robot_x, robot_y, robot_theta, ranges)
    global points

    if isempty(points)
        points = [0 0];
    end
    if on_goal == 1
        angles = linspace(0, 2*pi, numel(ranges));
        % 70 points, to the left and forward
        top = mod(339 + round(robot_theta), 360);
        bot = mod(270 + round(robot_theta), 360);
        R = ranges(top:bot);
        A = angles(top:bot);
         
        % 10 avgs for 0-10, 10-20 etc
        avg_R = mean(reshape(R, 10, []), 1);
        avg_A = mean(reshape(A, 10, []), 1);
        
        % cartesian wall points w.r.t robot
        [avg_x, avg_y] = pol2cart(avg_A, avg_R);
        points_R = [avg_x;avg_y]'*rot2(-90,'deg');
        % homo
        points_R = [points_R, ones(size(points_R, 1 ), 1)];
    
        % transformation from robot to world
        T = [rot2(robot_theta) [robot_x; robot_y]; 0 0 1];
        
        % points w.r.t world
        points_W = (T*points_R')';
        points = points_W + [0 dist_to_wall 0];
        points = [
            points(1,1), points(1,2)
            %points(4,1), points(4,2)
        ]';
    end
end