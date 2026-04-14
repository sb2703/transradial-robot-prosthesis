function R = R_z(alpha)
% Given an angle, computes elemental rotation matrix around Z axis.
% IN - alpha: input angle
% OUT - R: elemental rotation matrix around Z axis

R = [cos(alpha), -sin(alpha), 0;
     sin(alpha),  cos(alpha), 0;
              0,           0, 1];
end
