function [p] = points_to_plot_t(q, a, w0_T_t0)
% Auxiliary function to compute points to plot of thumb.
% IN - q: joint variables of thumb
% IN - a: anthropometric parameters of thumb
% IN - w0_T_t0: transformation matrix from wrist to thumb base
% OUT - p: points to plot of thumb

% Extraction of joint variables of thumb
q_t1 = q(1);
q_t2 = q(2);
q_t3 = q(3);
q_t4 = q(4);

% Extraction of anthropometric parameters of thumb
a_t1 = a(1);
a_t2 = a(2);
a_t3 = a(3);
a_t4 = a(4);

% Points to plot of thumb
t0_T_t1 = [cos(q_t1), 0,  sin(q_t1), a_t1*cos(q_t1);
           sin(q_t1), 0, -cos(q_t1), a_t1*sin(q_t1);
                   0, 1,          0,              0;
                   0, 0,          0,              1];
w0_T_t1 = w0_T_t0*t0_T_t1;
p_t1 = w0_T_t1(1:3, 4);

t0_T_t2 = [cos(q_t1)*cos(q_t2), -cos(q_t1)*sin(q_t2),  sin(q_t1), cos(q_t1)*(a_t1 + a_t2*cos(q_t2));
           cos(q_t2)*sin(q_t1), -sin(q_t1)*sin(q_t2), -cos(q_t1), sin(q_t1)*(a_t1 + a_t2*cos(q_t2));
                     sin(q_t2),            cos(q_t2),          0,                    a_t2*sin(q_t2);
                             0,                    0,          0,                                 1];
w0_T_t2 = w0_T_t0*t0_T_t2;
p_t2 = w0_T_t2(1:3, 4);

t0_T_t3 = [cos(q_t2 + q_t3)*cos(q_t1), -sin(q_t2 + q_t3)*cos(q_t1),  sin(q_t1), cos(q_t1)*(a_t1 + a_t3*cos(q_t2 + q_t3) + a_t2*cos(q_t2));
           cos(q_t2 + q_t3)*sin(q_t1), -sin(q_t2 + q_t3)*sin(q_t1), -cos(q_t1), sin(q_t1)*(a_t1 + a_t3*cos(q_t2 + q_t3) + a_t2*cos(q_t2));
                     sin(q_t2 + q_t3),            cos(q_t2 + q_t3),          0,                    a_t3*sin(q_t2 + q_t3) + a_t2*sin(q_t2);
                                    0,                           0,          0,                                                         1];
w0_T_t3 = w0_T_t0*t0_T_t3;
p_t3 = w0_T_t3(1:3, 4);

t0_T_t4 = [cos(q_t2 + q_t3 + q_t4)*cos(q_t1), -sin(q_t1), -sin(q_t2 + q_t3 + q_t4)*cos(q_t1), cos(q_t1)*(a_t1 + a_t3*cos(q_t2 + q_t3) + a_t2*cos(q_t2) + a_t4*cos(q_t2 + q_t3 + q_t4));
           cos(q_t2 + q_t3 + q_t4)*sin(q_t1),  cos(q_t1), -sin(q_t2 + q_t3 + q_t4)*sin(q_t1), sin(q_t1)*(a_t1 + a_t3*cos(q_t2 + q_t3) + a_t2*cos(q_t2) + a_t4*cos(q_t2 + q_t3 + q_t4));
                     sin(q_t2 + q_t3 + q_t4),          0,            cos(q_t2 + q_t3 + q_t4),                    a_t3*sin(q_t2 + q_t3) + a_t2*sin(q_t2) + a_t4*sin(q_t2 + q_t3 + q_t4);
                                           0,          0,                                  0,                                                                                        1];
w0_T_t4 = w0_T_t0*t0_T_t4;
p_t4 = w0_T_t4(1:3, 4);

p = [w0_T_t0(1:3, 4), p_t1, p_t2, p_t3, p_t4];
end