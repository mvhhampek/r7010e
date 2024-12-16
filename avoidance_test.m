function asd = avoidance_test(r, x, y, z, x_a, y_a, z_a, x_ref, y_ref, z_ref)
    asd = 0;

    [x_sphere, y_sphere, z_sphere] = sphere(50);
    x_sphere = r * x_sphere + x_a; 
    y_sphere = r * y_sphere + y_a;
    z_sphere = r * z_sphere + z_a;

    scatter3(x_a, y_a, z_a, 100, 'r', 'filled');
    hold on
    surf(x_sphere, y_sphere, z_sphere, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    hold on
    scatter3(x,y,z,100,'bo')
    hold on
    scatter3(x_ref, y_ref, z_ref, 100, 'rx')
    
    xlim([-1 5])
    ylim([-1 5])
    zlim([-1 5])
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('Point with Surrounding Sphere');
    grid on;
    hold off;
end