function I_c = link_inertia(m, r, l, R_c)
% Computes inertia tensor of link in RF_0.
% IN - m: mass of link
% IN - r: radius of link
% IN - l: length of link
% IN - R_c: rotation matrix between RF_0 and RF_c
% OUT - I_c: inertia tensor of link in RF_0

% Inertia tensor of link in RF_c
I_xx = (sym(1)/12)*m*(3*r^2 + l^2);
I_yy = I_xx;
I_zz = (sym(1)/2)*m*r^2;
c_I_c = [I_xx,    0,    0;
            0, I_yy,    0;
            0,    0, I_zz];

% Application of rotation between RF_0 and RF_c
I_c = R_c*c_I_c*R_c.';
end
