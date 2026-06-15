function [p] = points_to_plot_nt(q, a, r, w0_T_nt0)
% Auxiliary function to compute points to plot of (given) non-thumb finger.
% IN - q: joint variables of non-thumb finger
% IN - a: anthropometric parameters of non-thumb finger
% IN - r: parameters for coupling of PIP and DIP joints
% IN - w0_T_nt0: transformation matrix from wrist to non-thumb finger base
% OUT - p: points to plot of non-thumb finger

% Extraction of joint variables of non-thumb finger
q_nt1 = q(1);
q_nt2 = q(2);
q_nt3 = q(3);

% Extraction of anthropometric parameters of non-thumb finger
a_nt1 = a(1);
a_nt2 = a(2);
a_nt3 = a(3);
a_nt4 = a(4);

% Extraction of parameters for coupling of PIP and DIP joints
r_f3 = r(1);
r_f4 = r(2);

% Points to plot of non-thumb finger
t0_T_nt1 = [cos(q_nt1), 0,  sin(q_nt1), a_nt1*cos(q_nt1);
            sin(q_nt1), 0, -cos(q_nt1), a_nt1*sin(q_nt1);
                     0, 1,           0,                0;
                     0, 0,           0,                1];
w0_T_nt1 = w0_T_nt0*t0_T_nt1;
p_nt1 = w0_T_nt1(1:3, 4);

t0_T_nt2 = [cos(q_nt1)*cos(q_nt2), -cos(q_nt1)*sin(q_nt2),  sin(q_nt1), cos(q_nt1)*(a_nt1 + a_nt2*cos(q_nt2));
            cos(q_nt2)*sin(q_nt1), -sin(q_nt1)*sin(q_nt2), -cos(q_nt1), sin(q_nt1)*(a_nt1 + a_nt2*cos(q_nt2));
                       sin(q_nt2),             cos(q_nt2),           0,                      a_nt2*sin(q_nt2);
                                0,                      0,           0,                                     1];
w0_T_nt2 = w0_T_nt0*t0_T_nt2;
p_nt2 = w0_T_nt2(1:3, 4);

t0_T_nt3 = [cos(q_nt2 + q_nt3)*cos(q_nt1), -sin(q_nt2 + q_nt3)*cos(q_nt1),  sin(q_nt1), cos(q_nt1)*(a_nt1 + a_nt3*cos(q_nt2 + q_nt3) + a_nt2*cos(q_nt2));
            cos(q_nt2 + q_nt3)*sin(q_nt1), -sin(q_nt2 + q_nt3)*sin(q_nt1), -cos(q_nt1), sin(q_nt1)*(a_nt1 + a_nt3*cos(q_nt2 + q_nt3) + a_nt2*cos(q_nt2));
                       sin(q_nt2 + q_nt3),             cos(q_nt2 + q_nt3),           0,                      a_nt3*sin(q_nt2 + q_nt3) + a_nt2*sin(q_nt2);
                                        0,                              0,           0,                                                                1];
w0_T_nt3 = w0_T_nt0*t0_T_nt3;
p_nt3 = w0_T_nt3(1:3, 4);

t0_T_nt4 = [cos(q_nt2 + q_nt3 + (q_nt3*r_f3)/r_f4)*cos(q_nt1), -sin(q_nt1), -sin(q_nt2 + q_nt3 + (q_nt3*r_f3)/r_f4)*cos(q_nt1), cos(q_nt1)*(a_nt1 + a_nt3*cos(q_nt2 + q_nt3) + a_nt2*cos(q_nt2) + a_nt4*cos(q_nt2 + q_nt3 + (q_nt3*r_f3)/r_f4));
            cos(q_nt2 + q_nt3 + (q_nt3*r_f3)/r_f4)*sin(q_nt1),  cos(q_nt1), -sin(q_nt2 + q_nt3 + (q_nt3*r_f3)/r_f4)*sin(q_nt1), sin(q_nt1)*(a_nt1 + a_nt3*cos(q_nt2 + q_nt3) + a_nt2*cos(q_nt2) + a_nt4*cos(q_nt2 + q_nt3 + (q_nt3*r_f3)/r_f4));
                       sin(q_nt2 + q_nt3 + (q_nt3*r_f3)/r_f4),           0,             cos(q_nt2 + q_nt3 + (q_nt3*r_f3)/r_f4),                      a_nt3*sin(q_nt2 + q_nt3) + a_nt2*sin(q_nt2) + a_nt4*sin(q_nt2 + q_nt3 + (q_nt3*r_f3)/r_f4);
                                                            0,           0,                                                  0,                                                                                                               1];
w0_T_nt4 = w0_T_nt0*t0_T_nt4;
p_nt4 = w0_T_nt4(1:3, 4);

p = [w0_T_nt0(1:3, 4), p_nt1, p_nt2, p_nt3, p_nt4];
end