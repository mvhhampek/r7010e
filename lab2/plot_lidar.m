
function a = plot_lidar(ranges)
    a = 1;

    clf
    angles = linspace(0, 2*pi, numel(ranges));
    polarplot(angles, ranges);

end

