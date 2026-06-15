function [] = plot_hand(t, q, a, r, p, R_RPY)
% Plots 3D model of the whole hand.
% IN - t: title of plot
% IN - q: joint variables
% IN - a: anthropometric parameters of fingers
% IN - r: parameters for coupling of PIP and DIP joints
% IN - p: anthropometric parameters of palm
% IN - R_RPY: rotation matrix from wrist to thumb base

% Extraction of joint variables
q_w1 = q(1);
q_w2 = q(2);
q_w3 = q(3);

q_t = q(4:7);
q_i = q(8:10);
q_m = q(11:13);
q_r = q(14:16);
q_l = q(17:19);

% Extraction of anthropometric parameters of fingers
a_t = a(1, :);
a_i = a(2, :);
a_m = a(3, :);
a_r = a(4, :);
a_l = a(5, :);

% Extraction of anthropometric parameters of palm
d_pt = p(1);
a_pt = p(2);

d_pi = p(3);
a_pi = p(4);

d_pm = p(5);
a_pm = p(6);

d_pr = p(7);
a_pr = p(8);

d_pl = p(9);
a_pl = p(10);

% Points to plot of wrist
w0_T_w3 = [cos(q_w1)*sin(q_w3) + cos(q_w3)*sin(q_w1)*sin(q_w2), cos(q_w1)*cos(q_w3) - sin(q_w1)*sin(q_w2)*sin(q_w3), -cos(q_w2)*sin(q_w1), 0;
           sin(q_w1)*sin(q_w3) - cos(q_w1)*cos(q_w3)*sin(q_w2), cos(q_w3)*sin(q_w1) + cos(q_w1)*sin(q_w2)*sin(q_w3),  cos(q_w1)*cos(q_w2), 0;
                                           cos(q_w2)*cos(q_w3),                                -cos(q_w2)*sin(q_w3),            sin(q_w2), 0;
                                                             0,                                                   0,                    0, 1];
p_w = [zeros(3, 1), w0_T_w3(1:3, 4)];

% Points to plot of palm
w3_T_t0 = [1,  0, 0, a_pt;
           0,  0, 1,    0;
           0, -1, 0, d_pt;
           0,  0, 0,    1];

w3_T_t0 = w3_T_t0*[      R_RPY, zeros(3, 1);
                   zeros(1, 3),           1];

w0_T_t0 = w0_T_w3*w3_T_t0;
p_pt = w0_T_t0(1:3, 4);

w3_T_i0 = [1,  0, 0, a_pi;
           0,  0, 1,    0;
           0, -1, 0, d_pi;
           0,  0, 0,    1];
w0_T_i0 = w0_T_w3*w3_T_i0;
p_pi = w0_T_i0(1:3, 4);

w3_T_m0 = [1,  0, 0, a_pm;
           0,  0, 1,    0;
           0, -1, 0, d_pm;
           0,  0, 0,    1];
w0_T_m0 = w0_T_w3*w3_T_m0;
p_pm = w0_T_m0(1:3, 4);

w3_T_r0 = [1,  0, 0, a_pr;
           0,  0, 1,    0;
           0, -1, 0, d_pr;
           0,  0, 0,    1];
w0_T_r0 = w0_T_w3*w3_T_r0;
p_pr = w0_T_r0(1:3, 4);

w3_T_l0 = [1,  0, 0, a_pl;
           0,  0, 1,    0;
           0, -1, 0, d_pl;
           0,  0, 0,    1];
w0_T_l0 = w0_T_w3*w3_T_l0;
p_pl = w0_T_l0(1:3, 4);

T_pp = [1,  0, 0, a_pt;
        0,  0, 1,    0;
        0, -1, 0, d_pl;
        0,  0, 0,   1];
T_pp = w0_T_w3*T_pp;
p_pp = T_pp(1:3, 4);

p_p = [p_w(:, 2), p_pt, p_pi, p_pm, p_pr, p_pl, p_pp, p_w(:, 2)];

% Points to plot of thumb
p_t = points_to_plot_t(q_t, a_t, w0_T_t0);

% Points to plot of index finger
p_i = points_to_plot_nt(q_i, a_i, r, w0_T_i0);

% Points to plot of middle finger
p_m = points_to_plot_nt(q_m, a_m, r, w0_T_m0);

% Points to plot of ring finger
p_r = points_to_plot_nt(q_r, a_r, r, w0_T_r0);

% Points to plot of little finger
p_l = points_to_plot_nt(q_l, a_l, r, w0_T_l0);

% Plot of hand model
figure(Theme="light")
grid on
hold on
axis equal
xlabel("x (m)", "fontsize", 16);
ylabel("y (m)", "fontsize", 16);
zlabel("z (m)", "fontsize", 16);
title(t, "fontsize", 16);

plot3(p_w(1, :), p_w(2, :), p_w(3, :), "linewidth", 5, "marker", "*", "markersize", 7, "color", "k", "HandleVisibility", "off")
plot3(p_p(1, :), p_p(2, :), p_p(3, :), "linewidth", 5, "marker", "*", "markersize", 7, "color", "k")
plot3(p_t(1, :), p_t(2, :), p_t(3, :), "linewidth", 5, "marker", "*", "markersize", 7, "color", "r")
plot3(p_i(1, :), p_i(2, :), p_i(3, :), "linewidth", 5, "marker", "*", "markersize", 7, "color", "y")
plot3(p_m(1, :), p_m(2, :), p_m(3, :), "linewidth", 5, "marker", "*", "markersize", 7, "color", "g")
plot3(p_r(1, :), p_r(2, :), p_r(3, :), "linewidth", 5, "marker", "*", "markersize", 7, "color", "c")
plot3(p_l(1, :), p_l(2, :), p_l(3, :), "linewidth", 5, "marker", "*", "markersize", 7, "color", "m")

view([-305.0296, 9.9149])
plot_position = [0.6591, 0.5876, 0.0660, 0.1724];
legend("Palm", "Thumb", "Index", "Middle", "Ring", "Little", "fontsize", 12, "position", plot_position);
end