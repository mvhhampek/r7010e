function output = wall_controller_error(dist_to_wall, alpha, window_size, ranges)
    
    right = ranges(270-window_size:270+window_size);
    right = right((0.2 <= right) & (right <= 3));
    right_error = min(right) - dist_to_wall;

    if isequal(size(right_error), [0 1])
        right_error = 0;
    end

    min_ = 270-alpha;
    max_ = 270+alpha;

    right_back = ranges(min_-window_size:min_+window_size);
    right_back = right_back((0.2 <= right_back) & (right_back <= 3));

    right_forward = ranges(max_-window_size:max_+window_size);
    right_forward = right_forward((0.2 <= right_forward) & (right_forward <= 3));
    right_forward_error = min(right_forward) - dist_to_wall;


    a_error = mean(right_back) - mean(right_forward);


    forward = [ranges(1:window_size+1); ranges(359-window_size:359)];
    forward = forward((0.2 <= forward) & (forward <= 3));
    forward_error = min(forward) - dist_to_wall*1.5;

    d_error = min([right_error, right_forward_error, forward_error]);

    if isequal(size(d_error), [0 1])
        d_error = 0;
    end
    if isnan(d_error)
        d_error = 0;
    end
    if isnan(a_error)
        a_error = 0;
    end
    output = [d_error; a_error];
end