function R = R_y(beta)
% Given an angle, computes elemental rotation matrix around Y axis.
% IN - beta: input angle
% OUT - R: elemental rotation matrix around Y axis

R = [ cos(beta), 0, sin(beta);
              0, 1,         0;
     -sin(beta), 0, cos(beta)];
end
