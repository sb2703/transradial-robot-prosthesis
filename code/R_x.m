function R = R_x(gamma)
% Given an angle, computes elemental rotation matrix around X axis.
% IN - gamma: input angle
% OUT - R: elemental rotation matrix around X axis

R = [1,          0,           0;
     0, cos(gamma), -sin(gamma);
     0, sin(gamma),  cos(gamma)];
end
