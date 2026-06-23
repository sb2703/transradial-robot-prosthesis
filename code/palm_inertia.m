function I_p = palm_inertia(m, h, w, d, R_c)
% Computes inertia tensor of palm in RF_0.
% IN - m: mass of palm
% IN - h: height of palm
% IN - w: width of palm
% IN - d: depth of palm
% IN - R_c: rotation matrix between RF_0 and RF centered in palm CM
% OUT - I_p: inertia tensor of palm in RF_0

% Inertia tensor of palm in RF centered in palm CM
I_xx = (sym(1)/12)*m*(w^2 + h^2);
I_yy = (sym(1)/12)*m*(d^2 + h^2);
I_zz = (sym(1)/12)*m*(d^2 + w^2);
p_I_p = [I_xx,    0,    0;
            0, I_yy,    0;
            0,    0, I_zz];

% Application of rotation between RF_0 and RF centered in palm CM
I_p = R_c*p_I_p*R_c.';
I_p = simplify(I_p);
end
