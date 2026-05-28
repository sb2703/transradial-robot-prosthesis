clc
close all
clearvars

%-------------------------------------------------------------------------------
% SIMULATION PARAMETERS
%-------------------------------------------------------------------------------

% Resolution of workspace discretization
resolution = 24;

%-------------------------------------------------------------------------------
% MATRIX NEEDED FOR WORLD REFERENCE FRAME
%-------------------------------------------------------------------------------

w0_T_w3 = [0, 1, 0, 0;
           0, 0, 1, 0;
           1, 0, 0, 0;
           0, 0, 0, 1];
w0_R_w3 = w0_T_w3(1:3, 1:3);

w3_R_f0 = [1,  0, 0;
           0,  0, 1;
           0, -1, 0];
w0_R_f0 = w0_R_w3*w3_R_f0;

%-------------------------------------------------------------------------------
% RANGES OF MOTION (RoMs) OF FINGERS
%-------------------------------------------------------------------------------

% Ranges of Motion (RoMs) of thumb finger
rom_t1 = linspace(-pi/3, 0, resolution);
rom_t2 = linspace(0, pi/3, resolution);
rom_t3 = linspace(0, pi/3, resolution);
rom_t4 = linspace(0, 5*pi/12, resolution);
roms_t = [rom_t1; rom_t2; rom_t3; rom_t4];

% Ranges of Motion (RoMs) of index finger
rom_i1 = linspace(0, pi/6, resolution);
rom_i2 = linspace(0, pi/2, resolution);
rom_i3 = linspace(0, 11*pi/18, resolution);
roms_i = [rom_i1; rom_i2; rom_i3];

% Ranges of Motion (RoMs) of middle finger
rom_m1 = linspace(0, pi/6, resolution);
rom_m2 = linspace(0, 5*pi/9, resolution);
rom_m3 = linspace(0, 2*pi/3, resolution);
roms_m = [rom_m1; rom_m2; rom_m3];

% Ranges of Motion (RoMs) of ring finger
rom_r1 = linspace(0, pi/6, resolution);
rom_r2 = linspace(0, 5*pi/9, resolution);
rom_r3 = linspace(0, 2*pi/3, resolution);
roms_r = [rom_r1; rom_r2; rom_r3];

% Ranges of Motion (RoMs) of little finger
rom_l1 = linspace(0, pi/6, resolution);
rom_l2 = linspace(0, 11*pi/18, resolution);
rom_l3 = linspace(0, 3*pi/4, resolution);
roms_l = [rom_l1; rom_l2; rom_l3];

%-------------------------------------------------------------------------------
% ANTHROPOMETRIC PARAMETERS OF FINGERS
%-------------------------------------------------------------------------------

% Parameters of thumb
a_t1 = 0;
a_t2 = 0.076;
a_t3 = 0.031;
a_t4 = 0.019;
pars_t = [a_t1, a_t2, a_t3, a_t4];

% Parameters of index finger
a_i1 = 0;
a_i2 = 0.057;
a_i3 = 0.026;
a_i4 = 0.021;
pars_i = [a_i1, a_i2, a_i3, a_i4];

% Parameters of middle finger
a_m1 = 0;
a_m2 = 0.050;
a_m3 = 0.026;
a_m4 = 0.025;
pars_m = [a_m1, a_m2, a_m3, a_m4];

% Parameters of ring finger
a_r1 = 0;
a_r2 = 0.048;
a_r3 = 0.026;
a_r4 = 0.023;
pars_r = [a_r1, a_r2, a_r3, a_r4];

% Parameters of little finger
a_l1= 0;
a_l2 = 0.038;
a_l3 = 0.024;
a_l4 = 0.016;
pars_l = [a_l1, a_l2, a_l3, a_l4];

%-------------------------------------------------------------------------------
% ANTHROPOMETRIC PARAMETERS OF PALM
%-------------------------------------------------------------------------------

% Parameters of palm related to thumb
a_pt = 0;
d_pt = 0.025;

% Parameters of palm related to index finger
a_pi = 0.070;
d_pi = 0.025;

% Parameters of palm related to middle finger
a_pm = 0.078;
d_pm = 0;

% Parameters of palm related to ring finger
a_pr = 0.072;
d_pr = -0.025;

% Parameters of palm related to little finger
a_pl = 0.068; 
d_pl = -0.050;

%-------------------------------------------------------------------------------
% WORKSPACE OF THUMB
%-------------------------------------------------------------------------------

% Rotation matrix from wrist to thumb base
theta_z = -5*pi/36;
theta_y = -3*pi/36;
theta_x = -19*pi/36;

R_RPY = R_z(theta_z)*R_y(theta_y)*R_x(theta_x);

% Workspace of thumb finger
ps_t = workspace_t(roms_t, pars_t, R_RPY);

w3_T_t0 = [1,  0, 0, a_pt;
           0,  0, 1,    0;
           0, -1, 0, d_pt;
           0,  0, 0,    1];
w0_T_t0 = w0_T_w3*w3_T_t0;
ps_t = w0_T_t0(1:3, 1:3)*ps_t + w0_T_t0(1:3, 4);

%-------------------------------------------------------------------------------
% WORKSPACE OF NON-THUMB FINGERS
%-------------------------------------------------------------------------------

% Workspace of index finger
ps_i = workspace_nt(roms_i, pars_i);

w3_T_i0 = [1,  0, 0, a_pi;
           0,  0, 1,    0;
           0, -1, 0, d_pi;
           0,  0, 0,    1];
w0_T_i0 = w0_T_w3*w3_T_i0;
ps_i = w0_T_i0(1:3, 1:3)*ps_i + w0_T_i0(1:3, 4);

% Workspace of middle finger
ps_m = workspace_nt(roms_m, pars_m);

w3_T_m0 = [1,  0, 0, a_pm;
           0,  0, 1,    0;
           0, -1, 0, d_pm;
           0,  0, 0,    1];
w0_T_m0 = w0_T_w3*w3_T_m0;
ps_m = w0_T_m0(1:3, 1:3)*ps_m + w0_T_m0(1:3, 4);

% Workspace of ring finger
ps_r = workspace_nt(roms_r, pars_r);

w3_T_r0 = [1,  0, 0, a_pr;
           0,  0, 1,    0;
           0, -1, 0, d_pr;
           0,  0, 0,    1];
w0_T_r0 = w0_T_w3*w3_T_r0;
ps_r = w0_T_r0(1:3, 1:3)*ps_r + w0_T_r0(1:3, 4);

% Workspace of little finger
ps_l = workspace_nt(roms_l, pars_l);

w3_T_l0 = [1,  0, 0, a_pl;
           0,  0, 1,    0;
           0, -1, 0, d_pl;
           0,  0, 0,    1];
w0_T_l0 = w0_T_w3*w3_T_l0;
ps_l = w0_T_l0(1:3, 1:3)*ps_l + w0_T_l0(1:3, 4);

%-------------------------------------------------------------------------------
% PLOT OF WORKSPACES OF ALL FINGERS
%-------------------------------------------------------------------------------

figure(Theme="light")
grid on
hold on
axis equal
set(gca, 'Xdir', 'reverse')
xlabel("y (m)", "fontsize", 16);
ylabel("x (m)", "fontsize", 16);
zlabel("z (m)", "fontsize", 16);
title("Workspaces of fingers", "fontsize", 16);

% Plot of hand model
line_p = [0, 0, 0, 0, 0, 0, 0;
          d_pl, d_pl, d_pr, d_pm, d_pi, d_pi, d_pl;
          0, a_pl, a_pr, a_pm, a_pi, 0, 0];

line_t = [a_t1, a_t1 + a_t2, a_t1 + a_t2 + a_t3, a_t1 + a_t2 + a_t3 + a_t4;
          0, 0, 0, 0;
          0, 0, 0, 0];
line_t = w0_R_f0*R_RPY*line_t + [a_pt; d_pt; 0];

line_i = [0, 0, 0, 0;
          d_pi, d_pi, d_pi, d_pi;
          a_pi + a_i1, a_pi + a_i1 + a_i2, a_pi + a_i1 + a_i2 + a_i3, a_pi + a_i1 + a_i2 + a_i3 + a_i4];

line_m = [0, 0, 0, 0;
          d_pm, d_pm, d_pm, d_pm;
          a_pm + a_m1, a_pm + a_m1 + a_m2, a_pm + a_m1 + a_m2 + a_m3, a_pm + a_m1 + a_m2 + a_m3 + a_m4];

line_r = [0, 0, 0, 0;
          d_pr, d_pr, d_pr, d_pr;
          a_pr + a_r1, a_pr + a_r1 + a_r2, a_pr + a_r1 + a_r2 + a_r3, a_pr + a_r1 + a_r2 + a_r3 + a_r4];

line_l = [0, 0, 0, 0;
          d_pl, d_pl, d_pl, d_pl;
          a_pl + a_l1, a_pl + a_l1 + a_l2, a_pl + a_l1 + a_l2 + a_l3, a_pl + a_l1 + a_l2 + a_l3 + a_l4];

plot3(line_p(2, :), line_p(1, :), line_p(3, :), "linewidth", 5, "color", "k", "HandleVisibility", "off");
plot3(line_t(2, :), line_t(1, :), line_t(3, :), "linewidth", 5, "marker", "*", "markersize", 7, "color", "k");
plot3(line_i(2, :), line_i(1, :), line_i(3, :), "linewidth", 5, "marker", "*", "markersize", 7, "color", "k", "HandleVisibility", "off");
plot3(line_m(2, :), line_m(1, :), line_m(3, :), "linewidth", 5, "marker", "*", "markersize", 7, "color", "k", "HandleVisibility", "off");
plot3(line_r(2, :), line_r(1, :), line_r(3, :), "linewidth", 5, "marker", "*", "markersize", 7, "color", "k", "HandleVisibility", "off");
plot3(line_l(2, :), line_l(1, :), line_l(3, :), "linewidth", 5, "marker", "*", "markersize", 7, "color", "k", "HandleVisibility", "off");

% Plot of workspaces
plot3(ps_t(2, :), ps_t(1, :), ps_t(3, :), "linestyle", "none", "marker", ".", "color", "r");
plot3(ps_i(2, :), ps_i(1, :), ps_i(3, :), "linestyle", "none", "marker", ".", "color", "y");
plot3(ps_m(2, :), ps_m(1, :), ps_m(3, :), "linestyle", "none", "marker", ".", "color", "g");
plot3(ps_r(2, :), ps_r(1, :), ps_r(3, :), "linestyle", "none", "marker", ".", "color", "c");
plot3(ps_l(2, :), ps_l(1, :), ps_l(3, :), "linestyle", "none", "marker", ".", "color", "m");

view(162.2937, 9.4820)
% view(90, 0)
legend_names = ["Hand model", "Thumb", "Index", "Middle", "Ring", "Little"];
plot_position = [0.6612, 0.6035, 0.0895, 0.1724];
% plot_position = [0.5883, 0.7215, 0.0895, 0.1724];
legend(legend_names, "FontSize", 12, "Position", plot_position);

%-------------------------------------------------------------------------------
% WORKSPACE OF WRIST
%-------------------------------------------------------------------------------

% In the complete hand, the parameter d_w3 is zero
% In this simulation, the parameter d_w3 is non-zero for the sake of plotting

% Parameter of wrist
d_w3 = 1.0;

% Ranges of Motion (RoMs) of wrist
rom_w1 = linspace(-17*pi/36, 17*pi/36, 4*resolution);
rom_w2 = linspace(-pi/12, pi/4, 4*resolution);
rom_w3 = linspace(-17*pi/36, pi/2, 4*resolution);
roms_w = [rom_w1; rom_w2; rom_w3];

% Workspace of wrist
ps_w = workspace_w(roms_w, d_w3);

%-------------------------------------------------------------------------------
% PLOT OF WORKSPACE OF WRIST
%-------------------------------------------------------------------------------

figure(Theme="light")
grid on
hold on
axis equal
xlabel("x (m)", "fontsize", 16);
ylabel("y (m)", "fontsize", 16);
zlabel("z (m)", "fontsize", 16);
title("Workspace of wrist", "fontsize", 16);

% Plot of workspaces
plot3(ps_w(1, :), ps_w(2, :), ps_w(3, :), "linestyle", "none", "marker", ".");

legend("Wrist", "fontsize", 12);