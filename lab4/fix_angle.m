function ang = fix_angle(angle)
ang = angle;
if angle > pi/2
    ang = angle - pi;
end
if angle < -pi/2
    ang = angle + pi;
end
end