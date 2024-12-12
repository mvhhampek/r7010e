function output = MEKATRONIK(dist_to_wall, alpha, window_size, ranges)
    R = ranges(265:276);
    d_error = min(R) - dist_to_wall;
    min_ = 270-alpha;
    max_ = 270+alpha;
    a_error = mean(ranges(min_-window_size:min_+window_size)) - mean(ranges(max_-window_size:max_+window_size));
    %a_error = mean(ranges(224:227)) - mean(ranges(314:317));
    output = [d_error; a_error];
end