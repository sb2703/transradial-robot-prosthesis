function [T] = DH(dh_table)
% Computes transformation matrix from RF_0 to RF_n,
% using Denavit-Hartenberg (DH) convention for reference frames.
% IN - dh_table: matrix of DH parameters with rows [a_i, alpha_i, d_i, theta_i]
% OUT - T: transformation matrix from RF_0 to RF_n

% Initialization
T = eye(4);

% Computation of T
for i = 1:size(dh_table, 1)
    
    % Extraction of parameters from i-th row of DH parameters table
    a_i = dh_table(i, 1);
    al_i = dh_table(i, 2);
    d_i = dh_table(i, 3);
    th_i = dh_table(i, 4);
    
    % Update of T
    T = T*[cos(th_i), -cos(al_i)*sin(th_i),  sin(al_i)*sin(th_i), a_i*cos(th_i);
           sin(th_i),  cos(al_i)*cos(th_i), -sin(al_i)*cos(th_i), a_i*sin(th_i);
                   0,            sin(al_i),            cos(al_i),           d_i;
                   0,                    0,                    0,             1];
    T = simplify(T);
end
end
