
x = x_exp.Data;
y = y_exp.Data;
ranges = ranges_exp.Data;
theta = theta_exp.Data;


angles = linspace(0, 2*pi, 360);
scans = zeros(length(x));
for i = 1:length(x)
    scans(i) = lidarScan(ranges(i, :), angles);
end

occ_map = buildMap(scans, [x, y, theta], 10, 3.5);
show(occ_map)
