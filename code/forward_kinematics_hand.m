clc
close all
clearvars

%-------------------------------------------------------------------------------
% TRANSFORMATION MATRICES: BASE MANIPULATORS
%-------------------------------------------------------------------------------

% Computation of transformation matrix for the spherical wrist
syms q_w1 q_w2 q_w3 real
q_w = [q_w1; q_w2; q_w3];

DH_w = [0, -sym(pi)/2, 0, q_w1 - sym(pi)/2;
        0,  sym(pi)/2, 0, q_w2 - sym(pi)/2;
        0,          0, 0,             q_w3];
w0_T_w3 = simplify(DH(DH_w));

% Computation of transformation matrix for the fingers
syms q_f1 q_f2 q_f3 q_f4 real
q_f_t = [q_f1; q_f2; q_f3; q_f4];
q_f_nt = [q_f1; q_f2; q_f3];

syms a_f1 a_f2 a_f3 a_f4 real positive
a_f = [a_f1, a_f2, a_f3, a_f4];

DH_f = [a_f1,  sym(pi)/2, 0, q_f1;
        a_f2,          0, 0, q_f2;
        a_f3,          0, 0, q_f3;
        a_f4, -sym(pi)/2, 0, q_f4];
f0_T_f4 = simplify(DH(DH_f));

%-------------------------------------------------------------------------------
% KINEMATIC CONSTRAINTS OF NON-THUMB FINGERS
%-------------------------------------------------------------------------------

syms r_f3 r_f4 real positive
f0_T_nt4 = simplify(subs(f0_T_f4, q_f4, (r_f3/r_f4)*q_f3));

%-------------------------------------------------------------------------------
% TRANSFORMATION MATRICES: FROM WRIST TO FINGERS BASE
%-------------------------------------------------------------------------------

% Transformation matrix from wrist to non-thumb finger base
syms a_pf d_pf real positive
w3_T_f0 = [1,  0, 0, a_pf;
           0,  0, 1,    0;
           0, -1, 0, d_pf;
           0,  0, 0,    1];

% Transformation matrix from wrist to thumb base
syms a_pt d_pt real positive
w3_T_t0 = subs(w3_T_f0, [a_pf, d_pf], [a_pt, d_pt]);

theta_z = -5*sym(pi)/36;
theta_y = -3*sym(pi)/36;
theta_x = -19*sym(pi)/36;

R_RPY = R_z(theta_z)*R_y(theta_y)*R_x(theta_x);
w3_T_t0 = w3_T_t0*[simplify(R_RPY), zeros(3, 1);
                       zeros(1, 3),           1];

% Transformation matrix from wrist to index base
syms a_pi d_pi real positive
w3_T_i0 = subs(w3_T_f0, [a_pf, d_pf], [a_pi, d_pi]);

% Transformation matrix from wrist to middle base
syms a_pm d_pm real positive
w3_T_m0 = subs(w3_T_f0, [a_pf, d_pf], [a_pm, d_pm]);

% Transformation matrix from wrist to ring base
syms a_pr d_pr real positive
w3_T_r0 = subs(w3_T_f0, [a_pf, d_pf], [a_pr, d_pr]);

% Transformation matrix from wrist to little base
syms a_pl d_pl real positive
w3_T_l0 = subs(w3_T_f0, [a_pf, d_pf], [a_pl, d_pl]);

%-------------------------------------------------------------------------------
% TRANSFORMATION MATRICES: FROM FOREARM TO FINGERTIPS
%-------------------------------------------------------------------------------

tic;

% Transformation matrix from forearm to thumb fingertip
disp("Computing transformation matrix from forearm to thumb fingertip...")

syms q_t1 q_t2 q_t3 q_t4 real
syms a_t1 a_t2 a_t3 a_t4 real positive
q_t = [q_t1; q_t2; q_t3; q_t4];
a_t = [a_t1, a_t2, a_t3, a_t4];

t0_T_t4 = subs(f0_T_f4, [q_f_t.', a_f], [q_t.', a_t]);
w0_T_t0 = simplify(w0_T_w3*w3_T_t0);
w0_T_t4 = simplify(w0_T_t0*t0_T_t4);

% Transformation matrix from forearm to index fingertip
disp("Computing transformation matrix from forearm to index fingertip...")

syms q_i1 q_i2 q_i3 real
syms a_i1 a_i2 a_i3 a_i4 real positive
q_i = [q_i1; q_i2; q_i3];
a_i = [a_i1, a_i2, a_i3, a_i4];

i0_T_i4 = subs(f0_T_nt4, [q_f_nt.', a_f], [q_i.', a_i]);
w0_T_i0 = simplify(w0_T_w3*w3_T_i0);
w0_T_i4 = simplify(w0_T_i0*i0_T_i4);

% Transformation matrix from forearm to middle fingertip
disp("Computing transformation matrix from forearm to middle fingertip...")

syms q_m1 q_m2 q_m3 real
syms a_m1 a_m2 a_m3 a_m4 real positive
q_m = [q_m1; q_m2; q_m3];
a_m = [a_m1, a_m2, a_m3, a_m4];

m0_T_m4 = subs(f0_T_nt4, [q_f_nt.', a_f], [q_m.', a_m]);
w0_T_m0 = simplify(w0_T_w3*w3_T_m0);
w0_T_m4 = simplify(w0_T_m0*m0_T_m4);

% Transformation matrix from forearm to ring fingertip
disp("Computing transformation matrix from forearm to ring fingertip...")

syms q_r1 q_r2 q_r3 real
syms a_r1 a_r2 a_r3 a_r4 real positive
q_r = [q_r1; q_r2; q_r3];
a_r = [a_r1, a_r2, a_r3, a_r4];

r0_T_r4 = subs(f0_T_nt4, [q_f_nt.', a_f], [q_r.', a_r]);
w0_T_r0 = simplify(w0_T_w3*w3_T_r0);
w0_T_r4 = simplify(w0_T_r0*r0_T_r4);

% Transformation matrix from forearm to little fingertip
disp("Computing transformation matrix from forearm to little fingertip...")

syms q_l1 q_l2 q_l3 real
syms a_l1 a_l2 a_l3 a_l4 real positive
q_l = [q_l1; q_l2; q_l3];
a_l = [a_l1, a_l2, a_l3, a_l4];

l0_T_l4 = subs(f0_T_nt4, [q_f_nt.', a_f], [q_l.', a_l]);
w0_T_l0 = simplify(w0_T_w3*w3_T_l0);
w0_T_l4 = simplify(w0_T_l0*l0_T_l4);

% Time necessary to compute forward kinematics
T = toc;
disp(['Forward kinematics of whole hand computed in ', num2str(T), ' seconds.'])