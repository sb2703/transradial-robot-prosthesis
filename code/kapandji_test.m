% IMPORTANT: This script has to be executed in the same workspace
% where the script 'forward_kinematics_hand' has been executed

%-------------------------------------------------------------------------------
% VARIABLES AND PARAMETERS SHARED BY MORE THAN ONE TEST
%-------------------------------------------------------------------------------

% Rotation matrix from wrist to thumb base
theta_z = -5*pi/36;
theta_y = -3*pi/36;
theta_x = -19*pi/36;

R_RPY = R_z(theta_z)*R_y(theta_y)*R_x(theta_x);

%-------------------------------------------------------------------------------
% END STOPS
%-------------------------------------------------------------------------------

% End stops of thumb
es_t_1 = [-pi/3, 0];
es_t_2 = [0, pi/3];
es_t_3 = [0, pi/3];
es_t_4 = [0, 5*pi/12];
es_t = [es_t_1; 
        es_t_2; 
        es_t_3; 
        es_t_4];

% End stops of index finger
es_i_1 = [0, pi/6];
es_i_2 = [0, pi/2];
es_i_3 = [0, 11*pi/18];
es_i = [es_i_1; 
        es_i_2; 
        es_i_3];

% End stops of middle finger
es_m_1 = [0, pi/6];
es_m_2 = [0, 5*pi/9];
es_m_3 = [0, 2*pi/3];
es_m = [es_m_1; 
        es_m_2; 
        es_m_3];

% End stops of ring finger
es_r_1 = [0, pi/6];
es_r_2 = [0, 5*pi/9];
es_r_3 = [0, 2*pi/3];
es_r = [es_r_1; 
        es_r_2; 
        es_r_3];

% End stops of little finger
es_l_1 = [0, pi/6];
es_l_2 = [0, 11*pi/18];
es_l_3 = [0, 3*pi/4];
es_l = [es_l_1; 
        es_l_2; 
        es_l_3];

%-------------------------------------------------------------------------------
% ANTHROPOMETRIC PARAMETERS OF FINGERS
%-------------------------------------------------------------------------------

% Parameters of thumb
a_t1_test = 0;
a_t2_test = 0.076;
a_t3_test = 0.031;
a_t4_test = 0.019;
a_t_test = [a_t1_test, a_t2_test, a_t3_test, a_t4_test];

% Parameters of index finger
a_i1_test = 0;
a_i2_test = 0.057;
a_i3_test = 0.026;
a_i4_test = 0.021;
a_i_test = [a_i1_test, a_i2_test, a_i3_test, a_i4_test];

% Parameters of middle finger
a_m1_test = 0;
a_m2_test = 0.050;
a_m3_test = 0.026;
a_m4_test = 0.025;
a_m_test = [a_m1_test, a_m2_test, a_m3_test, a_m4_test];

% Parameters of ring finger
a_r1_test = 0;
a_r2_test = 0.048;
a_r3_test = 0.026;
a_r4_test = 0.023;
a_r_test = [a_r1_test, a_r2_test, a_r3_test, a_r4_test];

% Parameters of little finger
a_l1_test = 0;
a_l2_test = 0.038;
a_l3_test = 0.024;
a_l4_test = 0.016;
a_l_test = [a_l1_test, a_l2_test, a_l3_test, a_l4_test];

% Grouping of parameters
a = [a_t_test;
     a_i_test;
     a_m_test;
     a_r_test;
     a_l_test];

%-------------------------------------------------------------------------------
% PARAMETERS FOR COUPLING OF PIP AND DIP JOINTS
%-------------------------------------------------------------------------------

% Symbolic parameters for coupling of PIP and DIP joints
sym_r = [r_f3; 
         r_f4];

% Parameters for coupling of PIP and DIP joints
r_f3_test = 0.002;
r_f4_test = 0.003;
r = [r_f3_test; 
     r_f4_test];

%-------------------------------------------------------------------------------
% ANTHROPOMETRIC PARAMETERS OF PALM
%-------------------------------------------------------------------------------

% Parameters of palm related to thumb
d_pt_test = 0.025;
a_pt_test = 0;

% Parameters of palm related to index finger
d_pi_test = 0.025;
a_pi_test = 0.070;

% Parameters of palm related to middle finger
d_pm_test = 0.000;
a_pm_test = 0.078;

% Parameters of palm related to ring finger
d_pr_test = -0.025;
a_pr_test = 0.072;

% Parameters of palm related to little finger
d_pl_test = -0.050;
a_pl_test = 0.068;

% Grouping of parameters
p = [d_pt_test;
     a_pt_test;
     d_pi_test;
     a_pi_test;
     d_pm_test;
     a_pm_test;
     d_pr_test;
     a_pr_test;
     d_pl_test;
     a_pl_test];

%-------------------------------------------------------------------------------
% WORKSPACES
%-------------------------------------------------------------------------------

% Resolution of workspace discretization
resolution = 12;

% Ranges of Motion (RoMs) of thumb
rom_t1 = linspace(es_t_1(1), es_t_1(2), resolution);
rom_t2 = linspace(es_t_2(1), es_t_2(2), resolution);
rom_t3 = linspace(es_t_3(1), es_t_3(2), resolution);
rom_t4 = linspace(es_t_4(1), es_t_4(2), resolution);
roms_t = [rom_t1; 
          rom_t2; 
          rom_t3; 
          rom_t4];

% Workspace of thumb
ps_t = workspace_t(roms_t, round(a_t_test, 6), R_RPY);
ps_t = ps_t + round([a_pt_test; -d_pt_test; 0], 6);

% Ranges of Motion (RoMs) of index finger
rom_i1 = linspace(es_i_1(1), es_i_1(2), resolution);
rom_i2 = linspace(es_i_2(1), es_i_2(2), resolution);
rom_i3 = linspace(es_i_3(1), es_i_3(2), resolution);
roms_i = [rom_i1; 
          rom_i2; 
          rom_i3];

% Workspace of index finger
ps_i = workspace_nt(roms_i, round(a_i_test, 6));
ps_i = ps_i + round([a_pi_test; -d_pi_test; 0], 6);

% Ranges of Motion (RoMs) of middle finger
rom_m1 = linspace(es_m_1(1), es_m_1(2), resolution);
rom_m2 = linspace(es_m_2(1), es_m_2(2), resolution);
rom_m3 = linspace(es_m_3(1), es_m_3(2), resolution);
roms_m = [rom_m1; 
          rom_m2; 
          rom_m3];

% Workspace of middle finger
ps_m = workspace_nt(roms_m, round(a_m_test, 6));
ps_m = ps_m + round([a_pm_test; -d_pm_test; 0], 6);

% Ranges of Motion (RoMs) of ring finger
rom_r1 = linspace(es_r_1(1), es_r_1(2), resolution);
rom_r2 = linspace(es_r_2(1), es_r_2(2), resolution);
rom_r3 = linspace(es_r_3(1), es_r_3(2), resolution);
roms_r = [rom_r1; 
          rom_r2; 
          rom_r3];

% Workspace of ring finger
ps_r = workspace_nt(roms_r, round(a_r_test, 6));
ps_r = ps_r + round([a_pr_test; -d_pr_test; 0], 6);

% Ranges of Motion (RoMs) of little finger
rom_l1 = linspace(es_l_1(1), es_l_1(2), resolution);
rom_l2 = linspace(es_l_2(1), es_l_2(2), resolution);
rom_l3 = linspace(es_l_3(1), es_l_3(2), resolution);
roms_l = [rom_l1; 
          rom_l2; 
          rom_l3];

% Workspace of little finger
ps_l = workspace_nt(roms_l, round(a_l_test, 6));
ps_l = ps_l + round([a_pl_test; -d_pl_test; 0], 6);

% Workspace of index finger, but with reference to its distal phalanx
[ps_i_df, ps_i_df_tip] = workspace_df(roms_i, round(a_i_test, 6));
ps_i_df = ps_i_df + round([a_pi_test; -d_pi_test; 0], 6);
ps_i_df_tip = ps_i_df_tip + round([a_pi_test; -d_pi_test; 0], 6);

% Workspace of index finger, but with reference to its middle phalanx
[ps_i_mf, ps_i_mf_tip] = workspace_mf(roms_i, round(a_i_test, 6));
ps_i_mf = ps_i_mf + round([a_pi_test; -d_pi_test; 0], 6);
ps_i_mf_tip = ps_i_mf_tip + round([a_pi_test; -d_pi_test; 0], 6);

% Workspace of index finger, but with reference to its proximal
[ps_i_pf, ps_i_pf_tip] = workspace_pf(roms_i, round(a_i_test, 6));
ps_i_pf = ps_i_pf + round([a_pi_test; -d_pi_test; 0], 6);
ps_i_pf_tip = ps_i_pf_tip + round([a_pi_test; -d_pi_test; 0], 6);

% Workspace of little finger, but with reference to its DIP joint
[ps_l_dip, ps_l_dip_tip] = workspace_dip(roms_l, round(a_l_test, 6));
ps_l_dip = ps_l_dip + round([a_pl_test; -d_pl_test; 0], 6);
ps_l_dip_tip = ps_l_dip_tip + round([a_pl_test; -d_pl_test; 0], 6);

% Workspace of little finger, but with reference to its PIP joint
[ps_l_pip, ps_l_pip_tip] = workspace_pip(roms_l, round(a_l_test, 6));
ps_l_pip = ps_l_pip + round([a_pl_test; -d_pl_test; 0], 6);
ps_l_pip_tip = ps_l_pip_tip + round([a_pl_test; -d_pl_test; 0], 6);

%-------------------------------------------------------------------------------
% KAPANDJI TEST N° 0
%-------------------------------------------------------------------------------

disp("Executing Kapandji test n° 0...")

% Computation of contact point between thumb fingertip and proximal phalanx of index finger
tic;

[p_ks_0, index_0] = find_contact_point(ps_t, ps_i_pf);

T_c0 = toc;
disp(['Contact point for Kapandji test n° 0 computed in ', num2str(T_c0), ' seconds.']);

% Computation of joint variables for thumb
tic;

f_t_0 = subs(t0_T_t4(1:3, 4), a_t, a_t_test);

J_t_sym_0 = simplify(jacobian(f_t_0, q_t.'));

ref_t_0 = R_RPY.'*round(p_ks_0 - [a_pt_test; -d_pt_test; 0], 6);

q_0_t_0 = [(es_t_1(1) + es_t_1(2))/2;
           (es_t_2(1) + es_t_2(2))/2;
           (es_t_3(1) + es_t_3(2))/2;
           (es_t_4(1) + es_t_4(2))/2];

[q_h_t_0, i_t_0] = newton(ref_t_0, f_t_0, J_t_sym_0, q_t, q_0_t_0, es_t);
sol_t_0 = q_h_t_0(:, end);

T_t0 = toc;
disp(['Joint variables of thumb for Kapandji test n° 0 computed in ', num2str(T_t0), ' seconds.']);

% Computation of joint variables for index finger
tic;

f_i_0 = subs(i0_T_i4(1:3, 4), a_i, a_i_test);
f_i_0 = subs(f_i_0, sym_r.', r.');

J_i_sym_0 = simplify(jacobian(f_i_0, q_i.'));

ref_i_0 = round(ps_i_pf_tip(:, index_0) - [a_pi_test; -d_pi_test; 0], 6);

q_0_i_0 = [(es_i_1(1) + es_i_1(2))/2;
           (es_i_2(1) + es_i_2(2))/2;
           (es_i_3(1) + es_i_3(2))/2];

[q_h_i_0, i_i_0] = newton(ref_i_0, f_i_0, J_i_sym_0, q_i, q_0_i_0, es_i);
sol_i_0 = q_h_i_0(:, end);

T_i0 = toc;
disp(['Joint variables of index finger for Kapandji test n° 0 computed in ', num2str(T_i0), ' seconds.']);

% Values of joint variables
q_w1_test_0 = sym(0);
q_w2_test_0 = sym(0);
q_w3_test_0 = sym(0);
q_w_test_0 = [q_w1_test_0; q_w2_test_0; q_w3_test_0];

q_t1_test_0 = sol_t_0(1);
q_t2_test_0 = sol_t_0(2);
q_t3_test_0 = sol_t_0(3);
q_t4_test_0 = sol_t_0(4);
q_t_test_0 = [q_t1_test_0; q_t2_test_0; q_t3_test_0; q_t4_test_0];

q_i1_test_0 = sol_i_0(1);
q_i2_test_0 = sol_i_0(2);
q_i3_test_0 = sol_i_0(3);
q_i_test_0 = [q_i1_test_0; q_i2_test_0; q_i3_test_0];

q_m1_test_0 = sym(0);
q_m2_test_0 = sym(0);
q_m3_test_0 = sym(0);
q_m_test_0 = [q_m1_test_0; q_m2_test_0; q_m3_test_0];

q_r1_test_0 = sym(0);
q_r2_test_0 = sym(0);
q_r3_test_0 = sym(0);
q_r_test_0 = [q_r1_test_0; q_r2_test_0; q_r3_test_0];

q_l1_test_0 = sym(0);
q_l2_test_0 = sym(0);
q_l3_test_0 = sym(0);
q_l_test_0 = [q_l1_test_0; q_l2_test_0; q_l3_test_0];

vars_0 = [q_w_test_0;
          q_t_test_0;
          q_i_test_0;
          q_m_test_0;
          q_r_test_0;
          q_l_test_0];

% Plot of Kapandji test n° 0
t_0 = 'Kapandji test n° 0';
plot_hand(t_0, vars_0, a, r, p, R_RPY)

%-------------------------------------------------------------------------------
% KAPANDJI TEST N° 1
%-------------------------------------------------------------------------------

disp("Executing Kapandji test n° 1...")

% Computation of contact point between thumb fingertip and middle phalanx of index finger
tic;

[p_ks_1, index_1] = find_contact_point(ps_t, ps_i_mf);

T_c1 = toc;
disp(['Contact point for Kapandji test n° 1 computed in ', num2str(T_c1), ' seconds.']);

% Computation of joint variables for thumb
tic;

f_t_1 = subs(t0_T_t4(1:3, 4), a_t, a_t_test);

J_t_sym_1 = simplify(jacobian(f_t_1, q_t.'));

ref_t_1 = R_RPY.'*round(p_ks_1 - [a_pt_test; -d_pt_test; 0], 6);

q_0_t_1 = [(es_t_1(1) + es_t_1(2))/2;
           (es_t_2(1) + es_t_2(2))/2;
           (es_t_3(1) + es_t_3(2))/2;
           (es_t_4(1) + es_t_4(2))/2];

[q_h_t_1, i_t_1] = newton(ref_t_1, f_t_1, J_t_sym_1, q_t, q_0_t_1, es_t);
sol_t_1 = q_h_t_1(:, end);

T_t1 = toc;
disp(['Joint variables of thumb for Kapandji test n° 1 computed in ', num2str(T_t1), ' seconds.']);

% Computation of joint variables for index finger
tic;

f_i_1 = subs(i0_T_i4(1:3, 4), a_i, a_i_test);
f_i_1 = subs(f_i_1, sym_r.', r.');

J_i_sym_1 = simplify(jacobian(f_i_1, q_i.'));

ref_i_1 = round(ps_i_mf_tip(:, index_1) - [a_pi_test; -d_pi_test; 0], 6);

q_0_i_1 = [(es_i_1(1) + es_i_1(2))/2;
           (es_i_2(1) + es_i_2(2))/2;
           (es_i_3(1) + es_i_3(2))/2];

[q_h_i_1, i_i_1] = newton(ref_i_1, f_i_1, J_i_sym_1, q_i, q_0_i_1, es_i);
sol_i_1 = q_h_i_1(:, end);

T_i1 = toc;
disp(['Joint variables of index finger for Kapandji test n° 1 computed in ', num2str(T_i1), ' seconds.']);

% Values of joint variables
q_w1_test_1 = sym(0);
q_w2_test_1 = sym(0);
q_w3_test_1 = sym(0);
q_w_test_1 = [q_w1_test_1; q_w2_test_1; q_w3_test_1];

q_t1_test_1 = sol_t_1(1);
q_t2_test_1 = sol_t_1(2);
q_t3_test_1 = sol_t_1(3);
q_t4_test_1 = sol_t_1(4);
q_t_test_1 = [q_t1_test_1; q_t2_test_1; q_t3_test_1; q_t4_test_1];

q_i1_test_1 = sol_i_1(1);
q_i2_test_1 = sol_i_1(2);
q_i3_test_1 = sol_i_1(3);
q_i_test_1 = [q_i1_test_1; q_i2_test_1; q_i3_test_1];

q_m1_test_1 = sym(0);
q_m2_test_1 = sym(0);
q_m3_test_1 = sym(0);
q_m_test_1 = [q_m1_test_1; q_m2_test_1; q_m3_test_1];

q_r1_test_1 = sym(0);
q_r2_test_1 = sym(0);
q_r3_test_1 = sym(0);
q_r_test_1 = [q_r1_test_1; q_r2_test_1; q_r3_test_1];

q_l1_test_1 = sym(0);
q_l2_test_1 = sym(0);
q_l3_test_1 = sym(0);
q_l_test_1 = [q_l1_test_1; q_l2_test_1; q_l3_test_1];

vars_1 = [q_w_test_1;
          q_t_test_1;
          q_i_test_1;
          q_m_test_1;
          q_r_test_1;
          q_l_test_1];

% Plot of Kapandji test n° 1
t_1 = 'Kapandji test n° 1';
plot_hand(t_1, vars_1, a, r, p, R_RPY)

%-------------------------------------------------------------------------------
% KAPANDJI TEST N° 2
%-------------------------------------------------------------------------------

disp("Executing Kapandji test n° 2...")

% Computation of contact point between thumb fingertip and distal phalanx of index finger
tic;

[p_ks_2, index_2] = find_contact_point(ps_t, ps_i_df);

T_c2 = toc;
disp(['Contact point for Kapandji test n° 2 computed in ', num2str(T_c2), ' seconds.']);

% Computation of joint variables for thumb
tic;

f_t_2 = subs(t0_T_t4(1:3, 4), a_t, a_t_test);

J_t_sym_2 = simplify(jacobian(f_t_2, q_t.'));

ref_t_2 = R_RPY.'*round(p_ks_2 - [a_pt_test; -d_pt_test; 0], 6);

q_0_t_2 = [(es_t_1(1) + es_t_1(2))/2;
           (es_t_2(1) + es_t_2(2))/2;
           (es_t_3(1) + es_t_3(2))/2;
           (es_t_4(1) + es_t_4(2))/2];

[q_h_t_2, i_t_2] = newton(ref_t_2, f_t_2, J_t_sym_2, q_t, q_0_t_2, es_t);
sol_t_2 = q_h_t_2(:, end);

T_t2 = toc;
disp(['Joint variables of thumb for Kapandji test n° 2 computed in ', num2str(T_t2), ' seconds.']);

% Computation of joint variables for index finger
tic;

f_i_2 = subs(i0_T_i4(1:3, 4), a_i, a_i_test);
f_i_2 = subs(f_i_2, sym_r.', r.');

J_i_sym_2 = simplify(jacobian(f_i_2, q_i.'));

ref_i_2 = round(ps_i_df_tip(:, index_2) - [a_pi_test; -d_pi_test; 0], 6);

q_0_i_2 = [(es_i_1(1) + es_i_1(2))/2;
           (es_i_2(1) + es_i_2(2))/2;
           (es_i_3(1) + es_i_3(2))/2];

[q_h_i_2, i_i_2] = newton(ref_i_2, f_i_2, J_i_sym_2, q_i, q_0_i_2, es_i);
sol_i_2 = q_h_i_2(:, end);

T_i2 = toc;
disp(['Joint variables of index finger for Kapandji test n° 2 computed in ', num2str(T_i2), ' seconds.']);

% Values of joint variables
q_w1_test_2 = sym(0);
q_w2_test_2 = sym(0);
q_w3_test_2 = sym(0);
q_w_test_2 = [q_w1_test_2; q_w2_test_2; q_w3_test_2];

q_t1_test_2 = sol_t_2(1);
q_t2_test_2 = sol_t_2(2);
q_t3_test_2 = sol_t_2(3);
q_t4_test_2 = sol_t_2(4);
q_t_test_2 = [q_t1_test_2; q_t2_test_2; q_t3_test_2; q_t4_test_2];

q_i1_test_2 = sol_i_2(1);
q_i2_test_2 = sol_i_2(2);
q_i3_test_2 = sol_i_2(3);
q_i_test_2 = [q_i1_test_2; q_i2_test_2; q_i3_test_2];

q_m1_test_2 = sym(0);
q_m2_test_2 = sym(0);
q_m3_test_2 = sym(0);
q_m_test_2 = [q_m1_test_2; q_m2_test_2; q_m3_test_2];

q_r1_test_2 = sym(0);
q_r2_test_2 = sym(0);
q_r3_test_2 = sym(0);
q_r_test_2 = [q_r1_test_2; q_r2_test_2; q_r3_test_2];

q_l1_test_2 = sym(0);
q_l2_test_2 = sym(0);
q_l3_test_2 = sym(0);
q_l_test_2 = [q_l1_test_2; q_l2_test_2; q_l3_test_2];

vars_2 = [q_w_test_2;
          q_t_test_2;
          q_i_test_2;
          q_m_test_2;
          q_r_test_2;
          q_l_test_2];

% Plot of Kapandji test n° 2
t_2 = 'Kapandji test n° 2';
plot_hand(t_2, vars_2, a, r, p, R_RPY)

%-------------------------------------------------------------------------------
% KAPANDJI TEST N° 3
%-------------------------------------------------------------------------------

disp("Executing Kapandji test n° 3...")

% Computation of contact point between thumb fingertip and index fingertip
tic;

[p_ks_3, index_3] = find_contact_point(ps_t, ps_i);

T_c3 = toc;
disp(['Contact point for Kapandji test n° 3 computed in ', num2str(T_c3), ' seconds.']);

% Computation of joint variables for thumb
tic;

f_t_3 = subs(t0_T_t4(1:3, 4), a_t, a_t_test);

J_t_sym_3 = simplify(jacobian(f_t_3, q_t.'));

ref_t_3 = R_RPY.'*round(p_ks_3 - [a_pt_test; -d_pt_test; 0], 6);

q_0_t_3 = [(es_t_1(1) + es_t_1(2))/2;
           (es_t_2(1) + es_t_2(2))/2;
           (es_t_3(1) + es_t_3(2))/2;
           (es_t_4(1) + es_t_4(2))/2];

[q_h_t_3, i_t_3] = newton(ref_t_3, f_t_3, J_t_sym_3, q_t, q_0_t_3, es_t);
sol_t_3 = q_h_t_3(:, end);

T_t3 = toc;
disp(['Joint variables of thumb for Kapandji test n° 3 computed in ', num2str(T_t3), ' seconds.']);

% Computation of joint variables for index finger
tic;

f_i_3 = subs(i0_T_i4(1:3, 4), a_i, a_i_test);
f_i_3 = subs(f_i_3, sym_r.', r.');

J_i_sym_3 = simplify(jacobian(f_i_3, q_i.'));

ref_i_3 = round(p_ks_3 - [a_pi_test; -d_pi_test; 0], 6);

q_0_i_3 = [(es_i_1(1) + es_i_1(2))/2;
           (es_i_2(1) + es_i_2(2))/2;
           (es_i_3(1) + es_i_3(2))/2];

[q_h_i_3, i_i_3] = newton(ref_i_3, f_i_3, J_i_sym_3, q_i, q_0_i_3, es_i);
sol_i_3 = q_h_i_3(:, end);

T_i3 = toc;
disp(['Joint variables of index finger for Kapandji test n° 3 computed in ', num2str(T_i3), ' seconds.']);

% Values of joint variables
q_w1_test_3 = sym(0);
q_w2_test_3 = sym(0);
q_w3_test_3 = sym(0);
q_w_test_3 = [q_w1_test_3; q_w2_test_3; q_w3_test_3];

q_t1_test_3 = sol_t_3(1);
q_t2_test_3 = sol_t_3(2);
q_t3_test_3 = sol_t_3(3);
q_t4_test_3 = sol_t_3(4);
q_t_test_3 = [q_t1_test_3; q_t2_test_3; q_t3_test_3; q_t4_test_3];

q_i1_test_3 = sol_i_3(1);
q_i2_test_3 = sol_i_3(2);
q_i3_test_3 = sol_i_3(3);
q_i_test_3 = [q_i1_test_3; q_i2_test_3; q_i3_test_3];

q_m1_test_3 = sym(0);
q_m2_test_3 = sym(0);
q_m3_test_3 = sym(0);
q_m_test_3 = [q_m1_test_3; q_m2_test_3; q_m3_test_3];

q_r1_test_3 = sym(0);
q_r2_test_3 = sym(0);
q_r3_test_3 = sym(0);
q_r_test_3 = [q_r1_test_3; q_r2_test_3; q_r3_test_3];

q_l1_test_3 = sym(0);
q_l2_test_3 = sym(0);
q_l3_test_3 = sym(0);
q_l_test_3 = [q_l1_test_3; q_l2_test_3; q_l3_test_3];

vars_3 = [q_w_test_3;
          q_t_test_3;
          q_i_test_3;
          q_m_test_3;
          q_r_test_3;
          q_l_test_3];

% Plot of Kapandji test n° 3
t_3 = 'Kapandji test n° 3';
plot_hand(t_3, vars_3, a, r, p, R_RPY)

%-------------------------------------------------------------------------------
% KAPANDJI TEST N° 4
%-------------------------------------------------------------------------------

disp("Executing Kapandji test n° 4...")

% Computation of contact point between thumb fingertip and middle fingertip
tic;

[p_ks_4, index_4] = find_contact_point(ps_t, ps_m);

T_c4 = toc;
disp(['Contact point for Kapandji test n° 4 computed in ', num2str(T_c4), ' seconds.']);

% Computation of joint variables for thumb
tic;

f_t_4 = subs(t0_T_t4(1:3, 4), a_t, a_t_test);

J_t_sym_4 = simplify(jacobian(f_t_4, q_t.'));

ref_t_4 = R_RPY.'*round(p_ks_4 - [a_pt_test; -d_pt_test; 0], 6);

q_0_t_4 = [(es_t_1(1) + es_t_1(2))/2;
           (es_t_2(1) + es_t_2(2))/2;
           (es_t_3(1) + es_t_3(2))/2;
           (es_t_4(1) + es_t_4(2))/2];

[q_h_t_4, i_t_4] = newton(ref_t_4, f_t_4, J_t_sym_4, q_t, q_0_t_4, es_t);
sol_t_4 = q_h_t_4(:, end);

T_t4 = toc;
disp(['Joint variables of thumb for Kapandji test n° 4 computed in ', num2str(T_t4), ' seconds.']);

% Computation of joint variables for middle finger
tic;

f_m_4 = subs(m0_T_m4(1:3, 4), a_m, a_m_test);
f_m_4 = subs(f_m_4, sym_r.', r.');

J_m_sym_4 = simplify(jacobian(f_m_4, q_m.'));

ref_m_4 = round(p_ks_4 - [a_pm_test; -d_pm_test; 0], 6);

q_0_m_4 = [(es_m_1(1) + es_m_1(2))/2;
           (es_m_2(1) + es_m_2(2))/2;
           (es_m_3(1) + es_m_3(2))/2];

[q_h_m_4, i_m_4] = newton(ref_m_4, f_m_4, J_m_sym_4, q_m, q_0_m_4, es_m);
sol_m_4 = q_h_m_4(:, end);
T_m4 = toc;

disp(['Joint variables of middle finger for Kapandji test n° 4 computed in ', num2str(T_m4), ' seconds.']);

% Values of joint variables
q_w1_test_4 = sym(0);
q_w2_test_4 = sym(0);
q_w3_test_4 = sym(0);
q_w_test_4 = [q_w1_test_4; q_w2_test_4; q_w3_test_4];

q_t1_test_4 = sol_t_4(1);
q_t2_test_4 = sol_t_4(2);
q_t3_test_4 = sol_t_4(3);
q_t4_test_4 = sol_t_4(4);
q_t_test_4 = [q_t1_test_4; q_t2_test_4; q_t3_test_4; q_t4_test_4];

q_i1_test_4 = sym(0);
q_i2_test_4 = sym(0);
q_i3_test_4 = sym(0);
q_i_test_4 = [q_i1_test_4; q_i2_test_4; q_i3_test_4];

q_m1_test_4 = sol_m_4(1);
q_m2_test_4 = sol_m_4(2);
q_m3_test_4 = sol_m_4(3);
q_m_test_4 = [q_m1_test_4; q_m2_test_4; q_m3_test_4];

q_r1_test_4 = sym(0);
q_r2_test_4 = sym(0);
q_r3_test_4 = sym(0);
q_r_test_4 = [q_r1_test_4; q_r2_test_4; q_r3_test_4];

q_l1_test_4 = sym(0);
q_l2_test_4 = sym(0);
q_l3_test_4 = sym(0);
q_l_test_4 = [q_l1_test_4; q_l2_test_4; q_l3_test_4];

vars_4 = [q_w_test_4;
          q_t_test_4;
          q_i_test_4;
          q_m_test_4;
          q_r_test_4;
          q_l_test_4];

% Plot of Kapandji test n° 4
t_4 = 'Kapandji test n° 4';
plot_hand(t_4, vars_4, a, r, p, R_RPY)

%-------------------------------------------------------------------------------
% KAPANDJI TEST N° 5
%-------------------------------------------------------------------------------

disp("Executing Kapandji test n° 5...")

% Computation of contact point between thumb fingertip and ring fingertip
tic;

[p_ks_5, index_5] = find_contact_point(ps_t, ps_r);

T_c5 = toc;
disp(['Contact point for Kapandji test n° 5 computed in ', num2str(T_c5), ' seconds.']);

% Computation of joint variables for thumb
tic;

f_t_5 = subs(t0_T_t4(1:3, 4), a_t, a_t_test);

J_t_sym_5 = simplify(jacobian(f_t_5, q_t.'));

ref_t_5 = R_RPY.'*round(p_ks_5 - [a_pt_test; -d_pt_test; 0], 6);

q_0_t_5 = [(es_t_1(1) + es_t_1(2))/2;
           (es_t_2(1) + es_t_2(2))/2;
           (es_t_3(1) + es_t_3(2))/2;
           (es_t_4(1) + es_t_4(2))/2];

[q_h_t_5, i_t_5] = newton(ref_t_5, f_t_5, J_t_sym_5, q_t, q_0_t_5, es_t);
sol_t_5 = q_h_t_5(:, end);

T_t5 = toc;
disp(['Joint variables of thumb for Kapandji test n° 5 computed in ', num2str(T_t5), ' seconds.']);

% Computation of joint variables for ring finger
tic;

f_r_5 = subs(r0_T_r4(1:3, 4), a_r, a_r_test);
f_r_5 = subs(f_r_5, sym_r.', r.');

J_r_sym_5 = simplify(jacobian(f_r_5, q_r.'));

ref_r_5 = round(p_ks_5 - [a_pr_test; -d_pr_test; 0], 6);

q_0_r_5 = [(es_r_1(1) + es_r_1(2))/2;
           (es_r_2(1) + es_r_2(2))/2;
           (es_r_3(1) + es_r_3(2))/2];

[q_h_r_5, i_r_5] = newton(ref_r_5, f_r_5, J_r_sym_5, q_r, q_0_r_5, es_r);
sol_r_5 = q_h_r_5(:, end);

T_r5 = toc;
disp(['Joint variables of ring finger for Kapandji test n° 5 computed in ', num2str(T_r5), ' seconds.']);

% Values of joint variables
q_w1_test_5 = sym(0);
q_w2_test_5 = sym(0);
q_w3_test_5 = sym(0);
q_w_test_5 = [q_w1_test_5; q_w2_test_5; q_w3_test_5];

q_t1_test_5 = sol_t_5(1);
q_t2_test_5 = sol_t_5(2);
q_t3_test_5 = sol_t_5(3);
q_t4_test_5 = sol_t_5(4);
q_t_test_5 = [q_t1_test_5; q_t2_test_5; q_t3_test_5; q_t4_test_5];

q_i1_test_5 = sym(0);
q_i2_test_5 = sym(0);
q_i3_test_5 = sym(0);
q_i_test_5 = [q_i1_test_5; q_i2_test_5; q_i3_test_5];

q_m1_test_5 = sym(0);
q_m2_test_5 = sym(0);
q_m3_test_5 = sym(0);
q_m_test_5 = [q_m1_test_5; q_m2_test_5; q_m3_test_5];

q_r1_test_5 = sol_r_5(1);
q_r2_test_5 = sol_r_5(2);
q_r3_test_5 = sol_r_5(3);
q_r_test_5 = [q_r1_test_5; q_r2_test_5; q_r3_test_5];

q_l1_test_5 = sym(0);
q_l2_test_5 = sym(0);
q_l3_test_5 = sym(0);
q_l_test_5 = [q_l1_test_5; q_l2_test_5; q_l3_test_5];

vars_5 = [q_w_test_5;
          q_t_test_5;
          q_i_test_5;
          q_m_test_5;
          q_r_test_5;
          q_l_test_5];

% Plot of Kapandji test n° 5
t_5 = 'Kapandji test n° 5';
plot_hand(t_5, vars_5, a, r, p, R_RPY)

%-------------------------------------------------------------------------------
% KAPANDJI TEST N° 6
%-------------------------------------------------------------------------------

disp("Executing Kapandji test n° 6...")

% Computation of contact point between thumb fingertip and little fingertip
tic;

[p_ks_6, index_6] = find_contact_point(ps_t, ps_l);

T_c6 = toc;
disp(['Contact point for Kapandji test n° 6 computed in ', num2str(T_c6), ' seconds.']);

% Computation of joint variables for thumb
tic;

f_t_6 = subs(t0_T_t4(1:3, 4), a_t, a_t_test);

J_t_sym_6 = simplify(jacobian(f_t_6, q_t.'));

ref_t_6 = R_RPY.'*round(p_ks_6 - [a_pt_test; -d_pt_test; 0], 6);

q_0_t_6 = [(es_t_1(1) + es_t_1(2))/2;
           (es_t_2(1) + es_t_2(2))/2;
           (es_t_3(1) + es_t_3(2))/2;
           (es_t_4(1) + es_t_4(2))/2];

[q_h_t_6, i_t_6] = newton(ref_t_6, f_t_6, J_t_sym_6, q_t, q_0_t_6, es_t);
sol_t_6 = q_h_t_6(:, end);

T_t6 = toc;
disp(['Joint variables of thumb for Kapandji test n° 6 computed in ', num2str(T_t6), ' seconds.']);

% Computation of joint variables for little finger
tic;

f_l_6 = subs(l0_T_l4(1:3, 4), a_l, a_l_test);
f_l_6 = subs(f_l_6, sym_r.', r.');

J_l_sym_6 = simplify(jacobian(f_l_6, q_l.'));

ref_l_6 = round(p_ks_6 - [a_pl_test; -d_pl_test; 0], 6);

q_0_l_6 = [(es_l_1(1) + es_l_1(2))/2;
           (es_l_2(1) + es_l_2(2))/2;
           (es_l_3(1) + es_l_3(2))/2];

[q_h_l_6, i_l_6] = newton(ref_l_6, f_l_6, J_l_sym_6, q_l, q_0_l_6, es_l);
sol_l_6 = q_h_l_6(:, end);

T_l6 = toc;
disp(['Joint variables of little finger for Kapandji test n° 6 computed in ', num2str(T_l6), ' seconds.']);

% Values of joint variables
q_w1_test_6 = sym(0);
q_w2_test_6 = sym(0);
q_w3_test_6 = sym(0);
q_w_test_6 = [q_w1_test_6; q_w2_test_6; q_w3_test_6];

q_t1_test_6 = sol_t_6(1);
q_t2_test_6 = sol_t_6(2);
q_t3_test_6 = sol_t_6(3);
q_t4_test_6 = sol_t_6(4);
q_t_test_6 = [q_t1_test_6; q_t2_test_6; q_t3_test_6; q_t4_test_6];

q_i1_test_6 = sym(0);
q_i2_test_6 = sym(0);
q_i3_test_6 = sym(0);
q_i_test_6 = [q_i1_test_6; q_i2_test_6; q_i3_test_6];

q_m1_test_6 = sym(0);
q_m2_test_6 = sym(0);
q_m3_test_6 = sym(0);
q_m_test_6 = [q_m1_test_6; q_m2_test_6; q_m3_test_6];

q_r1_test_6 = sym(0);
q_r2_test_6 = sym(0);
q_r3_test_6 = sym(0);
q_r_test_6 = [q_r1_test_6; q_r2_test_6; q_r3_test_6];

q_l1_test_6 = sol_l_6(1);
q_l2_test_6 = sol_l_6(2);
q_l3_test_6 = sol_l_6(3);
q_l_test_6 = [q_l1_test_6; q_l2_test_6; q_l3_test_6];

vars_6 = [q_w_test_6;
          q_t_test_6;
          q_i_test_6;
          q_m_test_6;
          q_r_test_6;
          q_l_test_6];

% Plot of Kapandji test n° 6
t_6 = 'Kapandji test n° 6';
plot_hand(t_6, vars_6, a, r, p, R_RPY)

%-------------------------------------------------------------------------------
% KAPANDJI TEST N° 7
%-------------------------------------------------------------------------------

disp("Executing Kapandji test n° 7...")

% Computation of contact point between thumb fingertip and DIP joint of little finger
tic;

[p_ks_7, index_7] = find_contact_point(ps_t, ps_l_dip);

T_c7 = toc;
disp(['Contact point for Kapandji test n° 7 computed in ', num2str(T_c7), ' seconds.']);

% Computation of joint variables for thumb
tic;

f_t_7 = subs(t0_T_t4(1:3, 4), a_t, a_t_test);

J_t_sym_7 = simplify(jacobian(f_t_7, q_t.'));

ref_t_7 = R_RPY.'*round(p_ks_7 - [a_pt_test; -d_pt_test; 0], 6);

q_0_t_7 = [(es_t_1(1) + es_t_1(2))/2;
           (es_t_2(1) + es_t_2(2))/2;
           (es_t_3(1) + es_t_3(2))/2;
           (es_t_4(1) + es_t_4(2))/2];

[q_h_t_7, i_t_7] = newton(ref_t_7, f_t_7, J_t_sym_7, q_t, q_0_t_7, es_t);
sol_t_7 = q_h_t_7(:, end);

T_t7 = toc;
disp(['Joint variables of thumb for Kapandji test n° 7 computed in ', num2str(T_t7), ' seconds.']);

% Computation of joint variables for little finger
tic;

f_l_7 = subs(l0_T_l4(1:3, 4), a_l, a_l_test);
f_l_7 = subs(f_l_7, sym_r.', r.');

J_l_sym_7 = simplify(jacobian(f_l_7, q_l.'));

ref_l_7 = round(ps_l_dip_tip(:, index_7) - [a_pl_test; -d_pl_test; 0], 6);

q_0_l_7 = [(es_l_1(1) + es_l_1(2))/2;
           (es_l_2(1) + es_l_2(2))/2;
           (es_l_3(1) + es_l_3(2))/2];

[q_h_l_7, i_l_7] = newton(ref_l_7, f_l_7, J_l_sym_7, q_l, q_0_l_7, es_l);
sol_l_7 = q_h_l_7(:, end);

T_l7 = toc;
disp(['Joint variables of little finger for Kapandji test n° 7 computed in ', num2str(T_l7), ' seconds.']);

% Values of joint variables
q_w1_test_7 = sym(0);
q_w2_test_7 = sym(0);
q_w3_test_7 = sym(0);
q_w_test_7 = [q_w1_test_7; q_w2_test_7; q_w3_test_7];

q_t1_test_7 = sol_t_7(1);
q_t2_test_7 = sol_t_7(2);
q_t3_test_7 = sol_t_7(3);
q_t4_test_7 = sol_t_7(4);
q_t_test_7 = [q_t1_test_7; q_t2_test_7; q_t3_test_7; q_t4_test_7];

q_i1_test_7 = sym(0);
q_i2_test_7 = sym(0);
q_i3_test_7 = sym(0);
q_i_test_7 = [q_i1_test_7; q_i2_test_7; q_i3_test_7];

q_m1_test_7 = sym(0);
q_m2_test_7 = sym(0);
q_m3_test_7 = sym(0);
q_m_test_7 = [q_m1_test_7; q_m2_test_7; q_m3_test_7];

q_r1_test_7 = sym(0);
q_r2_test_7 = sym(0);
q_r3_test_7 = sym(0);
q_r_test_7 = [q_r1_test_7; q_r2_test_7; q_r3_test_7];

q_l1_test_7 = sol_l_7;
q_l2_test_7 = sol_l_7;
q_l3_test_7 = sol_l_7;
q_l_test_7 = [q_l1_test_7; q_l2_test_7; q_l3_test_7];

vars_7 = [q_w_test_7;
          q_t_test_7;
          q_i_test_7;
          q_m_test_7;
          q_r_test_7;
          q_l_test_7];

% Plot of Kapandji test n° 7
t_7 = 'Kapandji test n° 7';
plot_hand(t_7, vars_7, a, r, p, R_RPY)

%-------------------------------------------------------------------------------
% KAPANDJI TEST N° 8
%-------------------------------------------------------------------------------

disp("Executing Kapandji test n° 8...")

% Computation of contact point between thumb fingertip and PIP joint of little finger
tic;

disp("Executing Kapandji test n° 8...")
[p_ks_8, index_8] = find_contact_point(ps_t, ps_l_pip);

T_c8 = toc;
disp(['Contact point for Kapandji test n° 8 computed in ', num2str(T_c8), ' seconds.']);

% Computation of joint variables for thumb
tic;

f_t_8 = subs(t0_T_t4(1:3, 4), a_t, a_t_test);

J_t_sym_8 = simplify(jacobian(f_t_8, q_t.'));

ref_t_8 = R_RPY.'*round(p_ks_8 - [a_pt_test; -d_pt_test; 0], 6);

q_0_t_8 = [(es_t_1(1) + es_t_1(2))/2;
           (es_t_2(1) + es_t_2(2))/2;
           (es_t_3(1) + es_t_3(2))/2;
           (es_t_4(1) + es_t_4(2))/2];

[q_h_t_8, i_t_8] = newton(ref_t_8, f_t_8, J_t_sym_8, q_t, q_0_t_8, es_t);
sol_t_8 = q_h_t_8(:, end);

T_t8 = toc;
disp(['Joint variables of thumb for Kapandji test n° 8 computed in ', num2str(T_t8), ' seconds.']);

% Computation of joint variables for little finger
tic;

f_l_8 = subs(l0_T_l4(1:3, 4), a_l, a_l_test);
f_l_8 = subs(f_l_8, sym_r.', r.');

J_l_sym_8 = simplify(jacobian(f_l_8, q_l.'));

ref_l_8 = round(ps_l_pip_tip(:, index_8) - [a_pl_test; -d_pl_test; 0], 6);

q_0_l_8 = [(es_l_1(1) + es_l_1(2))/2;
           (es_l_2(1) + es_l_2(2))/2;
           (es_l_3(1) + es_l_3(2))/2];

[q_h_l_8, i_l_8] = newton(ref_l_8, f_l_8, J_l_sym_8, q_l, q_0_l_8, es_l);
sol_l_8 = q_h_l_8(:, end);

T_l8 = toc;
disp(['Joint variables of little finger for Kapandji test n° 8 computed in ', num2str(T_l8), ' seconds.']);

% Values of joint variables
q_w1_test_8 = sym(0);
q_w2_test_8 = sym(0);
q_w3_test_8 = sym(0);
q_w_test_8 = [q_w1_test_8; q_w2_test_8; q_w3_test_8];

q_t1_test_8 = sol_t_8(1);
q_t2_test_8 = sol_t_8(2);
q_t3_test_8 = sol_t_8(3);
q_t4_test_8 = sol_t_8(4);
q_t_test_8 = [q_t1_test_8; q_t2_test_8; q_t3_test_8; q_t4_test_8];

q_i1_test_8 = sym(0);
q_i2_test_8 = sym(0);
q_i3_test_8 = sym(0);
q_i_test_8 = [q_i1_test_8; q_i2_test_8; q_i3_test_8];

q_m1_test_8 = sym(0);
q_m2_test_8 = sym(0);
q_m3_test_8 = sym(0);
q_m_test_8 = [q_m1_test_8; q_m2_test_8; q_m3_test_8];

q_r1_test_8 = sym(0);
q_r2_test_8 = sym(0);
q_r3_test_8 = sym(0);
q_r_test_8 = [q_r1_test_8; q_r2_test_8; q_r3_test_8];

q_l1_test_8 = sol_l_8;
q_l2_test_8 = sol_l_8;
q_l3_test_8 = sol_l_8;
q_l_test_8 = [q_l1_test_8; q_l2_test_8; q_l3_test_8];

vars_8 = [q_w_test_8;
          q_t_test_8;
          q_i_test_8;
          q_m_test_8;
          q_r_test_8;
          q_l_test_8];

% Plot of Kapandji test n° 8
t_8 = 'Kapandji test n° 8';
plot_hand(t_8, vars_8, a, r, p, R_RPY)

%-------------------------------------------------------------------------------
% KAPANDJI TEST N° 9
%-------------------------------------------------------------------------------

disp("Executing Kapandji test n° 9...")

% Point to reach to achieve the test
p_ks_9 = [ a_pl_test;
          -d_pl_test;
                   0];

% Computation of joint variables for thumb
tic;

f_t_9 = subs(t0_T_t4(1:3, 4), a_t, a_t_test);

J_t_sym_9 = simplify(jacobian(f_t_9, q_t.'));

ref_t_9 = R_RPY.'*round(p_ks_9 - [a_pt_test; -d_pt_test; 0], 6);

q_0_t_9 = [(es_t_1(1) + es_t_1(2))/2;
           (es_t_2(1) + es_t_2(2))/2;
           (es_t_3(1) + es_t_3(2))/2;
           (es_t_4(1) + es_t_4(2))/2];

[q_h_t_9, i_t_9] = newton(ref_t_9, f_t_9, J_t_sym_9, q_t, q_0_t_9, es_t);
sol_t_9 = q_h_t_9(:, end);

T_t9 = toc;
disp(['Joint variables of thumb for Kapandji test n° 9 computed in ', num2str(T_t9), ' seconds.']);

% Values of joint variables
q_w1_test_9 = sym(0);
q_w2_test_9 = sym(0);
q_w3_test_9 = sym(0);
q_w_test_9 = [q_w1_test_9; q_w2_test_9; q_w3_test_9];

q_t1_test_9 = sol_t_9(1);
q_t2_test_9 = sol_t_9(2);
q_t3_test_9 = sol_t_9(3);
q_t4_test_9 = sol_t_9(4);
q_t_test_9 = [q_t1_test_9; q_t2_test_9; q_t3_test_9; q_t4_test_9];

q_i1_test_9 = sym(0);
q_i2_test_9 = sym(0);
q_i3_test_9 = sym(0);
q_i_test_9 = [q_i1_test_9; q_i2_test_9; q_i3_test_9];

q_m1_test_9 = sym(0);
q_m2_test_9 = sym(0);
q_m3_test_9 = sym(0);
q_m_test_9 = [q_m1_test_9; q_m2_test_9; q_m3_test_9];

q_r1_test_9 = sym(0);
q_r2_test_9 = sym(0);
q_r3_test_9 = sym(0);
q_r_test_9 = [q_r1_test_9; q_r2_test_9; q_r3_test_9];

q_l1_test_9 = sym(0);
q_l2_test_9 = sym(0);
q_l3_test_9 = sym(0);
q_l_test_9 = [q_l1_test_9; q_l2_test_9; q_l3_test_9];

vars_9 = [q_w_test_9;
          q_t_test_9;
          q_i_test_9;
          q_m_test_9;
          q_r_test_9;
          q_l_test_9];

% Plot of Kapandji test n° 9
t_9 = 'Kapandji test n° 9';
plot_hand(t_9, vars_9, a, r, p, R_RPY)

%-------------------------------------------------------------------------------
% KAPANDJI TEST N° 10
%-------------------------------------------------------------------------------

disp("Executing Kapandji test n° 10...")

% Point to reach to achieve the test
p_ks_10 = [(2/3)*a_pl_test;
                -d_pl_test;
                         0];

% Computation of joint variables for thumb
tic;

f_t_10 = subs(t0_T_t4(1:3, 4), a_t, a_t_test);

J_t_sym_10 = simplify(jacobian(f_t_10, q_t.'));

ref_t_10 = R_RPY.'*round(p_ks_10 - [a_pt_test; -d_pt_test; 0], 6);

q_0_t_10 = [(es_t_1(1) + es_t_1(2))/2;
            (es_t_2(1) + es_t_2(2))/2;
            (es_t_3(1) + es_t_3(2))/2;
            (es_t_4(1) + es_t_4(2))/2];

[q_h_t_10, i_t_10] = newton(ref_t_10, f_t_10, J_t_sym_10, q_t, q_0_t_10, es_t);
sol_t_10 = q_h_t_10(:, end);

T_t10 = toc;
disp(['Joint variables of thumb for Kapandji test n° 10 computed in ', num2str(T_t10), ' seconds.']);

% Values of joint variables
q_w1_test_10 = sym(0);
q_w2_test_10 = sym(0);
q_w3_test_10 = sym(0);
q_w_test_10 = [q_w1_test_9; q_w2_test_9; q_w3_test_9];

q_t1_test_10 = sol_t_10(1);
q_t2_test_10 = sol_t_10(2);
q_t3_test_10 = sol_t_10(3);
q_t4_test_10 = sol_t_10(4);
q_t_test_10 = [q_t1_test_10; q_t2_test_10; q_t3_test_10; q_t4_test_10];

q_i1_test_10 = sym(0);
q_i2_test_10 = sym(0);
q_i3_test_10 = sym(0);
q_i_test_10 = [q_i1_test_10; q_i2_test_10; q_i3_test_10];

q_m1_test_10 = sym(0);
q_m2_test_10 = sym(0);
q_m3_test_10 = sym(0);
q_m_test_10 = [q_m1_test_10; q_m2_test_10; q_m3_test_10];

q_r1_test_10 = sym(0);
q_r2_test_10 = sym(0);
q_r3_test_10 = sym(0);
q_r_test_10 = [q_r1_test_10; q_r2_test_10; q_r3_test_10];

q_l1_test_10 = sym(0);
q_l2_test_10 = sym(0);
q_l3_test_10 = sym(0);
q_l_test_10 = [q_l1_test_10; q_l2_test_10; q_l3_test_10];

vars_10 = [q_w_test_10;
           q_t_test_10;
           q_i_test_10;
           q_m_test_10;
           q_r_test_10;
           q_l_test_10];

% Plot of Kapandji test n° 10
t_10 = 'Kapandji test n° 10';
plot_hand(t_10, vars_10, a, r, p, R_RPY)