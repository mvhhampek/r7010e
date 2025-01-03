function output = MEKATRONIK(dist_to_wall, alpha, window_size, ranges)
    
    R = ranges(265:276);
    R = R((0.2 <= R) & (R <= 3));
    d_error1 = min(R) - dist_to_wall;
    if isequal(size(d_error1), [0 1])
        d_error1 = 0;
    end
    min_ = 270-alpha;
    max_ = 270+alpha;

    left = ranges(min_-window_size:min_+window_size);
    left = left((0.2 <= left) & (left <= 3));

    right = ranges(max_-window_size:max_+window_size);
    right = right((0.2 <= right) & (right <= 3));

    a_error = mean(left) - mean(right);
    forward = [ranges(1:window_size+1); ranges(359-window_size:359)];
    forward = forward((0.2 <= forward) & (forward <= 3));
    forward = min(forward) - dist_to_wall*1.5;


    %a_error = mean(ranges(224:227)) - mean(ranges(314:317));
    %a_error
    %d_error
    d_error2 = min(right) - dist_to_wall;
    d_error = min([d_error1, d_error2, forward]);

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