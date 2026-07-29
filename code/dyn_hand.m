clc
close all
clearvars

%-------------------------------------------------------------------------------
% PARAMETERS OF DYNAMIC MODEL
%-------------------------------------------------------------------------------

% Parameters of whole hand
density = sym(1109); % kg/m^3

% Parameters of wrist
l_w1 = sym(0);
l_w2 = sym(0);
l_w = [l_w1, l_w2];

w_link_radius = sym(0);

m_w1 = sym(0);
m_w2 = sym(0);
m_w = [m_w1, m_w2];

% Parameters of palm
a_p = sym(72)/1000;
d_p = sym(75)/1000;
p_thickness = sym(20)/1000;

d_pt = d_p/3;
a_pt = 0;

d_pi = d_p/3;
a_pi = a_p;

d_pm = 0;
a_pm = a_p;

d_pr = -d_p/3;
a_pr = a_p;

d_pl = -2*d_p/3;
a_pl = a_p;

p = [d_pt;
     a_pt;
     d_pi;
     a_pi;
     d_pm;
     a_pm;
     d_pr;
     a_pr;
     d_pl;
     a_pl];

m_p = density*a_p*d_p*p_thickness;

% Parameters shared by all fingers
f_radius = sym(10)/1000;

m_factor = density*sym(pi)*(f_radius^2);

k_j1 = sym(1)/10;
k_j2 = sym(1)/10;
k_j3 = sym(7)/100;
k_j4 = sym(5)/100;

% Parameters of thumb
theta_z = -5*sym(pi)/36; 
theta_y = -3*sym(pi)/36; 
theta_x = -19*sym(pi)/36; 

l_t1 = sym(0);
l_t2 = sym(76)/1000;
l_t3 = sym(31)/1000;
l_t4 = sym(19)/1000;
l_t = [l_t1, l_t2, l_t3, l_t4];

m_t1 = m_factor*l_t1;
m_t2 = m_factor*l_t2;
m_t3 = m_factor*l_t3;
m_t4 = m_factor*l_t4;
m_t = [m_t1, m_t2, m_t3, m_t4];

k_t1 = k_j1;
k_t2 = k_j2;
k_t3 = k_j3;
k_t4 = k_j4;
k_t = [k_t1, k_t2, k_t3, k_t4];

k_t1_0 = 0.2695;
k_t2_0 = -0.2695;
k_t3_0 = -0.0606;
k_t4_0 = -0.01225;
k_t_0 = [k_t1_0, k_t2_0, k_t3_0, k_t4_0];

% Parameters shared by non-thumb fingers
r_f3 = sym(2)/1000;
r_f4 = sym(3)/1000;
r = [r_f3, r_f4];

% Parameters of index finger
l_i1 = sym(0);
l_i2 = sym(57)/1000;
l_i3 = sym(26)/1000;
l_i4 = sym(21)/1000;
l_i = [l_i1, l_i2, l_i3, l_i4];

m_i1 = m_factor*l_i1;
m_i2 = m_factor*l_i2;
m_i3 = m_factor*l_i3;
m_i4 = m_factor*l_i4;
m_i = [m_i1, m_i2, m_i3, m_i4];

k_i1 = k_j1;
k_i2 = k_j2;
k_i3 = k_j3;
k_i4 = k_j4;
k_i = [k_i1, k_i2, k_i3, k_i4];

k_i1_0 = -0.1848;
k_i2_0 = -0.1848;
k_i3_0 = -0.0464;
k_i4_0 = (2/3)*k_i3_0;
k_i_0 = [k_i1_0, k_i2_0, k_i3_0, k_i4_0];

% Parameters of middle finger
l_m1 = sym(0);
l_m2 = sym(50)/1000;
l_m3 = sym(26)/1000;
l_m4 = sym(25)/1000;
l_m = [l_m1, l_m2, l_m3, l_m4];

m_m1 = m_factor*l_m1;
m_m2 = m_factor*l_m2;
m_m3 = m_factor*l_m3;
m_m4 = m_factor*l_m4;
m_m = [m_m1, m_m2, m_m3, m_m4];

k_m1 = k_j1;
k_m2 = k_j2;
k_m3 = k_j3;
k_m4 = k_j4;
k_m = [k_m1, k_m2, k_m3, k_m4];

k_m1_0 = -0.1744;
k_m2_0 = -0.1744;
k_m3_0 = -0.05592;
k_m4_0 = (2/3)*k_m3_0;
k_m_0 = [k_m1_0, k_m2_0, k_m3_0, k_m4_0];

% Parameters of ring finger
l_r1 = sym(0);
l_r2 = sym(48)/1000;
l_r3 = sym(26)/1000;
l_r4 = sym(23)/1000;
l_r = [l_r1, l_r2, l_r3, l_r4];

m_r1 = m_factor*l_r1;
m_r2 = m_factor*l_r2;
m_r3 = m_factor*l_r3;
m_r4 = m_factor*l_r4;
m_r = [m_r1, m_r2, m_r3, m_r4];

k_r1 = k_j1;
k_r2 = k_j2;
k_r3 = k_j3;
k_r4 = k_j4;
k_r = [k_r1, k_r2, k_r3, k_r4];

k_r1_0 = -0.1608;
k_r2_0 = -0.1608;
k_r3_0 = -0.05103;
k_r4_0 = (2/3)*k_r3_0;
k_r_0 = [k_r1_0, k_r2_0, k_r3_0, k_r4_0];

% Parameters of little finger
l_l1 = sym(0);
l_l2 = sym(38)/1000;
l_l3 = sym(24)/1000;
l_l4 = sym(16)/1000;
l_l = [l_l1, l_l2, l_l3, l_l4];

m_l1 = m_factor*l_l1;
m_l2 = m_factor*l_l2;
m_l3 = m_factor*l_l3;
m_l4 = m_factor*l_l4;
m_l = [m_l1, m_l2, m_l3, m_l4];

k_l1 = k_j1;
k_l2 = k_j2;
k_l3 = k_j3;
k_l4 = k_j4;
k_l = [k_l1, k_l2, k_l3, k_l4];

k_l1_0 = -0.103971;
k_l2_0 = -0.103971;
k_l3_0 = -0.0328112;
k_l4_0 = (2/3)*k_l3_0;
k_l_0 = [k_l1_0, k_l2_0, k_l3_0, k_l4_0];

% Vector of all parameters of fingers
a = [l_t; l_i; l_m; l_r; l_l];

%-------------------------------------------------------------------------------
% VARIABLES OF DYNAMIC MODEL
%-------------------------------------------------------------------------------

% Joint variables of wrist
syms q_w1 q_w2 q_w3 real
q_w = [q_w1;
       q_w2;
       q_w3];

% Joint velocities of wrist
syms q_w1_dot q_w2_dot q_w3_dot real
q_w_dot = [q_w1_dot; 
           q_w2_dot;
           q_w3_dot];

% Joint accelerations of wrist
syms q_w1_ddot q_w2_ddot q_w3_ddot real
q_w_ddot = [q_w1_ddot; 
            q_w2_ddot; 
            q_w3_ddot];

% Joint variables of thumb
syms q_t1 q_t2 q_t3 q_t4 real
q_t = [q_t1; 
       q_t2;
       q_t3;
       q_t4];

% Joint velocities of thumb
syms q_t1_dot q_t2_dot q_t3_dot q_t4_dot real
q_t_dot = [q_t1_dot;
           q_t2_dot;
           q_t3_dot;
           q_t4_dot];

% Joint accelerations of thumb
syms q_t1_ddot q_t2_ddot q_t3_ddot q_t4_ddot real
q_t_ddot = [q_t1_ddot;
            q_t2_ddot;
            q_t3_ddot;
            q_t4_ddot];

% Joint variables of index finger
syms q_i1 q_i2 q_i3 q_i4 real
q_i = [q_i1;
       q_i2;
       q_i3;
       q_i4];

% Joint velocities of index finger
syms q_i1_dot q_i2_dot q_i3_dot q_i4_dot real
q_i_dot = [q_i1_dot;
           q_i2_dot;
           q_i3_dot;
           q_i4_dot];

% Joint accelerations of index finger
syms q_i1_ddot q_i2_ddot q_i3_ddot q_i4_ddot real
q_i_ddot = [q_i1_ddot;
            q_i2_ddot;
            q_i3_ddot;
            q_i4_ddot];

% Joint variables of middle finger
syms q_m1 q_m2 q_m3 q_m4 real
q_m = [q_m1;
       q_m2;
       q_m3;
       q_m4];

% Joint velocities of middle finger
syms q_m1_dot q_m2_dot q_m3_dot q_m4_dot real
q_m_dot = [q_m1_dot;
           q_m2_dot;
           q_m3_dot;
           q_m4_dot];

% Joint accelerations of middle finger
syms q_m1_ddot q_m2_ddot q_m3_ddot q_m4_ddot real
q_m_ddot = [q_m1_ddot;
            q_m2_ddot;
            q_m3_ddot;
            q_m4_ddot];

% Joint variables of ring finger
syms q_r1 q_r2 q_r3 q_r4 real
q_r = [q_r1;
       q_r2;
       q_r3;
       q_r4];

% Joint velocities of ring finger
syms q_r1_dot q_r2_dot q_r3_dot q_r4_dot real
q_r_dot = [q_r1_dot;
           q_r2_dot;
           q_r3_dot;
           q_r4_dot];

% Joint accelerations of ring finger
syms q_r1_ddot q_r2_ddot q_r3_ddot q_r4_ddot real
q_r_ddot = [q_r1_ddot;
            q_r2_ddot;
            q_r3_ddot;
            q_r4_ddot];

% Joint variables of little finger
syms q_l1 q_l2 q_l3 q_l4 real
q_l = [q_l1;
       q_l2; 
       q_l3;
       q_l4];

% Joint velocities of little finger
syms q_l1_dot q_l2_dot q_l3_dot q_l4_dot real
q_l_dot = [q_l1_dot;
           q_l2_dot;
           q_l3_dot;
           q_l4_dot];

% Joint accelerations of little finger
syms q_l1_ddot q_l2_ddot q_l3_ddot q_l4_ddot real
q_l_ddot = [q_l1_ddot;
            q_l2_ddot;
            q_l3_ddot;
            q_l4_ddot];

% Joint variables of whole hand
q = [q_w;
     q_t;
     q_i;
     q_m;
     q_r;
     q_l];

% Joint velocities of whole hand
q_dot = [q_w_dot;
         q_t_dot;
         q_i_dot;
         q_m_dot;
         q_r_dot;
         q_l_dot];

% Joint accelerations of whole hand
q_ddot = [q_w_ddot;
          q_t_ddot;
          q_i_ddot;
          q_m_ddot;
          q_r_ddot;
          q_l_ddot];

%-------------------------------------------------------------------------------
% KINETIC ENERGY
%-------------------------------------------------------------------------------

tic;

% Mass matrix contribution of first link of wrist
disp("Computing mass matrix contribution of first link of wrist...")
z_w0 = eye(3)*[0; 0; 1];

p_w0w0 = [0; 0; 0];

r_cw1 = [0; 0; l_w1/2];

R_w1 = R_z(q_w1)*R_x(-sym(pi)/2)*R_y(sym(pi)/2);
I_cw1 = link_inertia(m_w1, w_link_radius, l_w1, R_w1);
I_cw1 = simplify(I_cw1);

J_w1_L1 = simplify(cross(z_w0, r_cw1 - p_w0w0));
J_w1_L2_end = zeros(3, 22);

J_w1_A1 = z_w0;
J_w1_A2_end = zeros(3, 22);

J_w1_L = [J_w1_L1, J_w1_L2_end];

J_w1_A = [J_w1_A1, J_w1_A2_end];

M_w1 = m_w1*(J_w1_L.'*J_w1_L) + J_w1_A.'*I_cw1*J_w1_A;

% Mass matrix contribution of second link of wrist
disp("Computing mass matrix contribution of second link of wrist...")
z_w1 = simplify(R_w1*[0; 0; 1]);

p_w0w1 = [0; 0; l_w1];

r_cw2 = [-(sym(1)/2)*l_w2*sin(q_w1)*cos(q_w2);
          (sym(1)/2)*l_w2*cos(q_w1)*cos(q_w2);
             l_w1 + (sym(1)/2)*l_w2*sin(q_w2)];

R_w2 = R_w1*R_z(q_w2)*R_z(-sym(pi)/2)*R_x(sym(pi)/2);
I_cw2 = link_inertia(m_w2, w_link_radius, l_w2, R_w2);
I_cw2 = simplify(I_cw2);

J_w2_L1 = simplify(cross(z_w0, r_cw2 - p_w0w0));
J_w2_L2 = simplify(cross(z_w1, r_cw2 - p_w0w1));
J_w2_L3_end = zeros(3, 21);

J_w2_A1 = z_w0;
J_w2_A2 = z_w1;
J_w2_A3_end = zeros(3, 21);

J_w2_L = [J_w2_L1, J_w2_L2, J_w2_L3_end];
J_w2_L = simplify(J_w2_L);

J_w2_A = [J_w2_A1, J_w2_A2, J_w2_A3_end];
J_w2_A = simplify(J_w2_A);

M_w2 = m_w2*(J_w2_L.'*J_w2_L) + J_w2_A.'*I_cw2*J_w2_A;

% Mass matrix contribution of third link of wrist (i.e. the palm)
disp("Computing mass matrix contribution of third link of wrist (i.e. the palm)...")
z_w2 = simplify(R_w2*[0; 0; 1]);

p_w0w2 = [-l_w2*sin(q_w1)*cos(q_w2);
           l_w2*cos(q_w1)*cos(q_w2);
              l_w1 + l_w2*sin(q_w2)];

R_w3 = R_w2*R_z(q_w3);
r_cw3 = R_w3*[a_p/2; 0; -d_p/6] + p_w0w1;

I_p = palm_inertia(m_p, a_p, d_p, p_thickness, R_w3);

J_w3_L1 = simplify(cross(z_w0, r_cw3 - p_w0w0));
J_w3_L2 = simplify(cross(z_w1, r_cw3 - p_w0w1));
J_w3_L3 = simplify(cross(z_w2, r_cw3 - p_w0w2));
J_w3_L4_end = zeros(3, 20);

J_w3_A1 = z_w0;
J_w3_A2 = z_w1;
J_w3_A3 = z_w2;
J_w3_A4_end = zeros(3, 20);

J_w3_L = [J_w3_L1, J_w3_L2, J_w3_L3, J_w3_L4_end];
J_w3_L = simplify(J_w3_L);

J_w3_A = [J_w3_A1, J_w3_A2, J_w3_A3, J_w3_A4_end];
J_w3_A = simplify(J_w3_A);

M_w3 = m_p*(J_w3_L.'*J_w3_L) + J_w3_A.'*I_p*J_w3_A;

% Total mass matrix contribution of wrist
disp("Computing total mass matrix contribution of wrist...")
M_w = M_w1 + M_w2 + M_w3;

% Mass matrix contribution of first link of thumb
disp("Computing mass matrix contribution of first link of thumb...")
p_w0t0 = R_w3*[0; 0; d_p/3] + p_w0w1;
R_RPY = R_z(theta_z)*R_y(theta_y)*R_x(theta_x);
R_t0 = simplify(R_w3*R_x(-sym(pi)/2)*R_RPY);

t0_z_t0 = eye(3)*[0; 0; 1];
z_t0 = simplify(R_t0*t0_z_t0);

t0_r_ct1 = [(l_t1/2)*cos(q_t1);
            (l_t1/2)*sin(q_t1);
                             0];
r_ct1 = simplify(R_t0*t0_r_ct1 + p_w0t0);

t0_R_t1 = R_z(q_t1)*R_x(sym(pi)/2);
R_t1 = simplify(R_t0*t0_R_t1);
I_ct1 = link_inertia(m_t1, f_radius, l_t1, R_t1);

J_t1_L1 = simplify(cross(z_w0, r_ct1 - p_w0w0));
J_t1_L2 = simplify(cross(z_w1, r_ct1 - p_w0w1));
J_t1_L3 = simplify(cross(z_w2, r_ct1 - p_w0w2));
J_t1_L1_L3 = [J_t1_L1, J_t1_L2, J_t1_L3];
J_t1_L4 = simplify(cross(z_t0, r_ct1 - p_w0t0));
J_t1_L5_end = zeros(3, 19);

J_t1_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_t1_A4 = z_t0;
J_t1_A5_end = zeros(3, 19);

J_t1_L = [J_t1_L1_L3, J_t1_L4, J_t1_L5_end];
J_t1_L = simplify(J_t1_L);

J_t1_A = [J_t1_A1_A3, J_t1_A4, J_t1_A5_end];
J_t1_A = simplify(J_t1_A);

M_t1 = m_t1*(J_t1_L.'*J_t1_L) + J_t1_A.'*I_ct1*J_t1_A;

% Mass matrix contribution of second link of thumb
disp("Computing mass matrix contribution of second link of thumb...")
z_t1 = R_t1*[0; 0; 1];

t0_p_t0t1 = [l_t1*cos(q_t1);
             l_t1*sin(q_t1);
                          0];
p_w0t1 = simplify(R_t0*t0_p_t0t1 + p_w0t0);

t0_r_ct2 = [(l_t1 + (l_t2/2)*cos(q_t2))*cos(q_t1);
            (l_t1 + (l_t2/2)*cos(q_t2))*sin(q_t1);
                               (l_t2/2)*sin(q_t2)];
r_ct2 = simplify(R_t0*t0_r_ct2 + p_w0t0);

R_t2 = simplify(R_t1*R_z(q_t2));
I_ct2 = link_inertia(m_t2, f_radius, l_t2, R_t2);

J_t2_L1 = cross(z_w0, r_ct2 - p_w0w0);
J_t2_L2 = cross(z_w1, r_ct2 - p_w0w1);
J_t2_L3 = cross(z_w2, r_ct2 - p_w0w2);
J_t2_L1_L3 = [J_t2_L1, J_t2_L2, J_t2_L3];
J_t2_L4 = cross(z_t0, r_ct2 - p_w0t0);
J_t2_L5 = cross(z_t1, r_ct2 - p_w0t1);
J_t2_L6_end = zeros(3, 18);

J_t2_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_t2_A4 = z_t0;
J_t2_A5 = z_t1;
J_t2_A6_end = zeros(3, 18);

J_t2_L = [J_t2_L1_L3, J_t2_L4, J_t2_L5, J_t2_L6_end];

J_t2_A = [J_t2_A1_A3, J_t2_A4, J_t2_A5, J_t2_A6_end];

M_t2 = m_t2*(J_t2_L.'*J_t2_L) + J_t2_A.'*I_ct2*J_t2_A;

% Mass matrix contribution of third link of thumb
disp("Computing mass matrix contribution of third link of thumb...")
z_t2 = R_t2*[0; 0; 1];

t0_p_t0t2 = [(l_t1 + l_t2*cos(q_t2))*cos(q_t1);
             (l_t1 + l_t2*cos(q_t2))*sin(q_t1);
                                l_t2*sin(q_t2)];
p_w0t2 = simplify(R_t0*t0_p_t0t2 + p_w0t0);

c_t2t3 = cos(q_t2 + q_t3);
s_t2t3 = sin(q_t2 + q_t3);
t0_r_ct3 = [(l_t1 + l_t2*cos(q_t2) + (l_t3/2)*c_t2t3)*cos(q_t1);
            (l_t1 + l_t2*cos(q_t2) + (l_t3/2)*c_t2t3)*sin(q_t1);
                               l_t2*sin(q_t2) + (l_t3/2)*s_t2t3];
r_ct3 = simplify(R_t0*t0_r_ct3 + p_w0t0);

R_t3 = simplify(R_t2*R_z(q_t3));
I_ct3 = link_inertia(m_t3, f_radius, l_t3, R_t3);

J_t3_L1 = cross(z_w0, r_ct3 - p_w0w0);
J_t3_L2 = cross(z_w1, r_ct3 - p_w0w1);
J_t3_L3 = cross(z_w2, r_ct3 - p_w0w2);
J_t3_L1_L3 = [J_t3_L1, J_t3_L2, J_t3_L3];
J_t3_L4 = cross(z_t0, r_ct3 - p_w0t0);
J_t3_L5 = cross(z_t1, r_ct3 - p_w0t1);
J_t3_L6 = cross(z_t2, r_ct3 - p_w0t2);
J_t3_L7_end = zeros(3, 17);

J_t3_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_t3_A4 = z_t0;
J_t3_A5 = z_t1;
J_t3_A6 = z_t2;
J_t3_A7_end = zeros(3, 17);

J_t3_L = [J_t3_L1_L3, J_t3_L4, J_t3_L5, J_t3_L6, J_t3_L7_end];

J_t3_A = [J_t3_A1_A3, J_t3_A4, J_t3_A5, J_t3_A6, J_t3_A7_end];

M_t3 = m_t3*(J_t3_L.'*J_t3_L) + J_t3_A.'*I_ct3*J_t3_A;

% Mass matrix contribution of fourth link of thumb
disp("Computing mass matrix contribution of fourth link of thumb...")
z_t3 = R_t3*[0; 0; 1];

t0_p_t0t3 = [(l_t1 + l_t2*cos(q_t2) + l_t3*c_t2t3)*cos(q_t1);
             (l_t1 + l_t2*cos(q_t2) + l_t3*c_t2t3)*sin(q_t1);
                                l_t2*sin(q_t2) + l_t3*s_t2t3];
p_w0t3 = simplify(R_t0*t0_p_t0t3 + p_w0t0);

c_t2t3t4 = cos(q_t2 + q_t3 + q_t4);
s_t2t3t4 = sin(q_t2 + q_t3 + q_t4);
t0_r_ct4 = [(l_t1 + l_t2*cos(q_t2) + l_t3*c_t2t3 + (l_t4/2)*c_t2t3t4)*cos(q_t1);
            (l_t1 + l_t2*cos(q_t2) + l_t3*c_t2t3 + (l_t4/2)*c_t2t3t4)*sin(q_t1);
                               l_t2*sin(q_t2) + l_t3*s_t2t3 + (l_t4/2)*s_t2t3t4];
r_ct4 = simplify(R_t0*t0_r_ct4 + p_w0t0);

R_t4 = simplify(R_t3*R_z(q_t4)*R_x(-sym(pi)/2));
I_ct4 = link_inertia(m_t4, f_radius, l_t4, R_t4);

J_t4_L1 = cross(z_w0, r_ct4 - p_w0w0);
J_t4_L2 = cross(z_w1, r_ct4 - p_w0w1);
J_t4_L3 = cross(z_w2, r_ct4 - p_w0w2);
J_t4_L1_L3 = [J_t4_L1, J_t4_L2, J_t4_L3];
J_t4_L4 = cross(z_t0, r_ct4 - p_w0t0);
J_t4_L5 = cross(z_t1, r_ct4 - p_w0t1);
J_t4_L6 = cross(z_t2, r_ct4 - p_w0t2);
J_t4_L7 = cross(z_t3, r_ct4 - p_w0t3);
J_t4_L8_end = zeros(3, 16);

J_t4_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_t4_A4 = z_t0;
J_t4_A5 = z_t1;
J_t4_A6 = z_t2;
J_t4_A7 = z_t3;
J_t4_A8_end = zeros(3, 16);

J_t4_L = [J_t4_L1_L3, J_t4_L4, J_t4_L5, J_t4_L6, J_t4_L7, J_t4_L8_end];

J_t4_A = [J_t4_A1_A3, J_t4_A4, J_t4_A5, J_t4_A6, J_t4_A7, J_t4_A8_end];

M_t4 = m_t4*(J_t4_L.'*J_t4_L) + J_t4_A.'*I_ct4*J_t4_A;

% Total mass matrix contribution of thumb
disp("Computing total mass matrix contribution of thumb...")
M_t = M_t1 + M_t2 + M_t3 + M_t4;

% Mass matrix contribution of first link of index finger
disp("Computing mass matrix contribution of first link of index finger...")
p_w0i0 = simplify(R_w3*[a_p; 0; d_p/3] + p_w0w1);
R_i0 = R_w3*R_x(-sym(pi)/2);

i0_z_i0 = eye(3)*[0; 0; 1];
z_i0 = simplify(R_i0*i0_z_i0);

i0_r_ci1 = [(l_i1/2)*cos(q_i1);
            (l_i1/2)*sin(q_i1);
                             0];
r_ci1 = simplify(R_i0*i0_r_ci1 + p_w0i0);

i0_R_i1 = R_z(q_i1)*R_x(sym(pi)/2);
R_i1 = simplify(R_i0*i0_R_i1);
I_ci1 = link_inertia(m_i1, f_radius, l_i1, R_i1);
I_ci1 = simplify(I_ci1);

J_i1_L1 = simplify(cross(z_w0, r_ci1 - p_w0w0));
J_i1_L2 = simplify(cross(z_w1, r_ci1 - p_w0w1));
J_i1_L3 = simplify(cross(z_w2, r_ci1 - p_w0w2));
J_i1_L1_L3 = [J_i1_L1, J_i1_L2, J_i1_L3];
J_i1_L4_L7 = zeros(3, 4);
J_i1_L8 = simplify(cross(z_i0, r_ci1 - p_w0i0));
J_i1_L9_end = zeros(3, 15);

J_i1_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_i1_A4_A7 = zeros(3, 4);
J_i1_A8 = z_i0;
J_i1_A9_end = zeros(3, 15);

J_i1_L = [J_i1_L1_L3, J_i1_L4_L7, J_i1_L8, J_i1_L9_end];
J_i1_L = simplify(J_i1_L);

J_i1_A = [J_i1_A1_A3, J_i1_A4_A7, J_i1_A8, J_i1_A9_end];
J_i1_A = simplify(J_i1_A);

M_i1 = m_i1*(J_i1_L.'*J_i1_L) + J_i1_A.'*I_ci1*J_i1_A;

% Mass matrix contribution of second link of index finger
disp("Computing mass matrix contribution of second link of index finger...")
z_i1 = R_i1*[0; 0; 1];

i0_p_i0i1 = [l_i1*cos(q_i1);
             l_i1*sin(q_i1);
                          0];
p_w0i1 = simplify(R_i0*i0_p_i0i1 + p_w0i0);

i0_r_ci2 = [(l_i1 + (l_i2/2)*cos(q_i2))*cos(q_i1);
            (l_i1 + (l_i2/2)*cos(q_i2))*sin(q_i1);
                               (l_i2/2)*sin(q_i2)];
r_ci2 = simplify(R_i0*i0_r_ci2 + p_w0i0);

R_i2 = simplify(R_i1*R_z(q_i2));
I_ci2 = link_inertia(m_i2, f_radius, l_i2, R_i2);
I_ci2 = simplify(I_ci2);

J_i2_L1 = simplify(cross(z_w0, r_ci2 - p_w0w0));
J_i2_L2 = simplify(cross(z_w1, r_ci2 - p_w0w1));
J_i2_L3 = simplify(cross(z_w2, r_ci2 - p_w0w2));
J_i2_L1_L3 = [J_i2_L1, J_i2_L2, J_i2_L3];
J_i2_L4_L7 = zeros(3, 4);
J_i2_L8 = simplify(cross(z_i0, r_ci2 - p_w0i0));
J_i2_L9 = simplify(cross(z_i1, r_ci2 - p_w0i1));
J_i2_L10_end = zeros(3, 14);

J_i2_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_i2_A4_A7 = zeros(3, 4);
J_i2_A8 = z_i0;
J_i2_A9 = z_i1;
J_i2_A10_end = zeros(3, 14);

J_i2_L = [J_i2_L1_L3, J_i2_L4_L7, J_i2_L8, J_i2_L9, J_i2_L10_end];
J_i2_L = simplify(J_i2_L);

J_i2_A = [J_i2_A1_A3, J_i2_A4_A7, J_i2_A8, J_i2_A9, J_i2_A10_end];
J_i2_A = simplify(J_i2_A);

M_i2 = m_i2*(J_i2_L.'*J_i2_L) + J_i2_A.'*I_ci2*J_i2_A;

% Mass matrix contribution of third link of index finger
disp("Computing mass matrix contribution of third link of index finger...")
z_i2 = R_i2*[0; 0; 1];

i0_p_i0i2 = [(l_i1 + l_i2*cos(q_i2))*cos(q_i1);
             (l_i1 + l_i2*cos(q_i2))*sin(q_i1);
                                l_i2*sin(q_i2)];
p_w0i2 = simplify(R_i0*i0_p_i0i2 + p_w0i0);

c_i2i3 = cos(q_i2 + q_i3);
s_i2i3 = sin(q_i2 + q_i3);
i0_r_ci3 = [(l_i1 + l_i2*cos(q_i2) + (l_i3/2)*c_i2i3)*cos(q_i1);
            (l_i1 + l_i2*cos(q_i2) + (l_i3/2)*c_i2i3)*sin(q_i1);
                               l_i2*sin(q_i2) + (l_i3/2)*s_i2i3];
r_ci3 = simplify(R_i0*i0_r_ci3 + p_w0i0);

R_i3 = simplify(R_i2*R_z(q_i3));
I_ci3 = link_inertia(m_i3, f_radius, l_i3, R_i3);
I_ci3 = simplify(I_ci3);

J_i3_L1 = simplify(cross(z_w0, r_ci3 - p_w0w0));
J_i3_L2 = simplify(cross(z_w1, r_ci3 - p_w0w1));
J_i3_L3 = simplify(cross(z_w2, r_ci3 - p_w0w2));
J_i3_L1_L3 = [J_i3_L1, J_i3_L2, J_i3_L3];
J_i3_L4_L7 = zeros(3, 4);
J_i3_L8 = simplify(cross(z_i0, r_ci3 - p_w0i0));
J_i3_L9 = simplify(cross(z_i1, r_ci3 - p_w0i1));
J_i3_L10 = simplify(cross(z_i2, r_ci3 - p_w0i2));
J_i3_L11_end = zeros(3, 13);

J_i3_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_i3_A4_A7 = zeros(3, 4);
J_i3_A8 = z_i0;
J_i3_A9 = z_i1;
J_i3_A10 = z_i2;
J_i3_A11_end = zeros(3, 13);

J_i3_L = [J_i3_L1_L3, J_i3_L4_L7, J_i3_L8, J_i3_L9, J_i3_L10, J_i3_L11_end];
J_i3_L = simplify(J_i3_L);

J_i3_A = [J_i3_A1_A3, J_i3_A4_A7, J_i3_A8, J_i3_A9, J_i3_A10, J_i3_A11_end];
J_i3_A = simplify(J_i3_A);

M_i3 = m_i3*(J_i3_L.'*J_i3_L) + J_i3_A.'*I_ci3*J_i3_A;

% Mass matrix contribution of fourth link of index finger
disp("Computing mass matrix contribution of fourth link of index finger...")
z_i3 = R_i3*[0; 0; 1];

i0_p_i0i3 = [(l_i1 + l_i2*cos(q_i2) + l_i3*c_i2i3)*cos(q_i1);
             (l_i1 + l_i2*cos(q_i2) + l_i3*c_i2i3)*sin(q_i1);
                                l_i2*sin(q_i2) + l_i3*s_i2i3];
p_w0i3 = simplify(R_i0*i0_p_i0i3 + p_w0i0);

c_i2i3i4 = cos(q_i2 + q_i3 + q_i4);
s_i2i3i4 = sin(q_i2 + q_i3 + q_i4);
i0_r_ci4 = [(l_i1 + l_i2*cos(q_i2) + l_i3*c_i2i3 + (l_i4/2)*c_i2i3i4)*cos(q_i1);
            (l_i1 + l_i2*cos(q_i2) + l_i3*c_i2i3 + (l_i4/2)*c_i2i3i4)*sin(q_i1);
                               l_i2*sin(q_i2) + l_i3*s_i2i3 + (l_i4/2)*s_i2i3i4];
r_ci4 = simplify(R_i0*i0_r_ci4 + p_w0i0);

R_i4 = simplify(R_i3*R_z(q_i4)*R_x(-sym(pi)/2));
I_ci4 = link_inertia(m_i4, f_radius, l_i4, R_i4);
I_ci4 = simplify(I_ci4);

J_i4_L1 = simplify(cross(z_w0, r_ci4 - p_w0w0));
J_i4_L2 = simplify(cross(z_w1, r_ci4 - p_w0w1));
J_i4_L3 = simplify(cross(z_w2, r_ci4 - p_w0w2));
J_i4_L1_L3 = [J_i4_L1, J_i4_L2, J_i4_L3];
J_i4_L4_L7 = zeros(3, 4);
J_i4_L8 = simplify(cross(z_i0, r_ci4 - p_w0i0));
J_i4_L9 = simplify(cross(z_i1, r_ci4 - p_w0i1));
J_i4_L10 = simplify(cross(z_i2, r_ci4 - p_w0i2));
J_i4_L11 = simplify(cross(z_i3, r_ci4 - p_w0i3));
J_i4_L12_end = zeros(3, 12);

J_i4_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_i4_A4_A7 = zeros(3, 4);
J_i4_A8 = z_i0;
J_i4_A9 = z_i1;
J_i4_A10 = z_i2;
J_i4_A11 = z_i3;
J_i4_A12_end = zeros(3, 12);

J_i4_L = [J_i4_L1_L3, J_i4_L4_L7, J_i4_L8, J_i4_L9, J_i4_L10, J_i4_L11, J_i4_L12_end];
J_i4_L = simplify(J_i4_L);

J_i4_A = [J_i4_A1_A3, J_i4_A4_A7, J_i4_A8, J_i4_A9, J_i4_A10, J_i4_A11, J_i4_A12_end];
J_i4_A = simplify(J_i4_A);

M_i4 = m_i4*(J_i4_L.'*J_i4_L) + J_i4_A.'*I_ci4*J_i4_A;

% Total mass matrix contribution of index finger
disp("Computing total mass matrix contribution of index finger...")
M_i = M_i1 + M_i2 + M_i3 + M_i4;

% Mass matrix contribution of first link of middle finger
disp("Computing mass matrix contribution of first link of middle finger...")
p_w0m0 = simplify(R_w3*[a_p; 0; 0] + p_w0w1);
R_m0 = R_w3*R_x(-sym(pi)/2);

m0_z_m0 = eye(3)*[0; 0; 1];
z_m0 = simplify(R_m0*m0_z_m0);

m0_r_cm1 = [(l_m1/2)*cos(q_m1);
            (l_m1/2)*sin(q_m1);
                             0];
r_cm1 = simplify(R_m0*m0_r_cm1 + p_w0m0);

m0_R_m1 = R_z(q_m1)*R_x(sym(pi)/2);
R_m1 = simplify(R_m0*m0_R_m1);
I_cm1 = link_inertia(m_m1, f_radius, l_m1, R_m1);
I_cm1 = simplify(I_cm1);

J_m1_L1 = simplify(cross(z_w0, r_cm1 - p_w0w0));
J_m1_L2 = simplify(cross(z_w1, r_cm1 - p_w0w1));
J_m1_L3 = simplify(cross(z_w2, r_cm1 - p_w0w2));
J_m1_L1_L3 = [J_m1_L1, J_m1_L2, J_m1_L3];
J_m1_L4_L11 = zeros(3, 8);
J_m1_L12 = simplify(cross(z_m0, r_cm1 - p_w0m0));
J_m1_L13_end = zeros(3, 11);

J_m1_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_m1_A4_A11 = zeros(3, 8);
J_m1_A12 = z_m0;
J_m1_A13_end = zeros(3, 11);

J_m1_L = [J_m1_L1_L3, J_m1_L4_L11, J_m1_L12, J_m1_L13_end];
J_m1_L = simplify(J_m1_L);

J_m1_A = [J_m1_A1_A3, J_m1_A4_A11, J_m1_A12, J_m1_A13_end];
J_m1_A = simplify(J_m1_A);

M_m1 = m_m1*(J_m1_L.'*J_m1_L) + J_m1_A.'*I_cm1*J_m1_A;

% Mass matrix contribution of second link of middle finger
disp("Computing mass matrix contribution of second link of middle finger...")
z_m1 = R_m1*[0; 0; 1];

m0_p_m0m1 = [l_m1*cos(q_m1);
             l_m1*sin(q_m1);
                          0];
p_w0m1 = simplify(R_m0*m0_p_m0m1 + p_w0m0);

m0_r_cm2 = [(l_m1 + (l_m2/2)*cos(q_m2))*cos(q_m1);
            (l_m1 + (l_m2/2)*cos(q_m2))*sin(q_m1);
                               (l_m2/2)*sin(q_m2)];
r_cm2 = simplify(R_m0*m0_r_cm2 + p_w0m0);

R_m2 = simplify(R_m1*R_z(q_m2));
I_cm2 = link_inertia(m_m2, f_radius, l_m2, R_m2);
I_cm2 = simplify(I_cm2);

J_m2_L1 = simplify(cross(z_w0, r_cm2 - p_w0w0));
J_m2_L2 = simplify(cross(z_w1, r_cm2 - p_w0w1));
J_m2_L3 = simplify(cross(z_w2, r_cm2 - p_w0w2));
J_m2_L1_L3 = [J_m2_L1, J_m2_L2, J_m2_L3];
J_m2_L4_L11 = zeros(3, 8);
J_m2_L12 = simplify(cross(z_m0, r_cm2 - p_w0m0));
J_m2_L13 = simplify(cross(z_m1, r_cm2 - p_w0m1));
J_m2_L14_end = zeros(3, 10);

J_m2_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_m2_A4_A11 = zeros(3, 8);
J_m2_A12 = z_m0;
J_m2_A13 = z_m1;
J_m2_A14_end = zeros(3, 10);

J_m2_L = [J_m2_L1_L3, J_m2_L4_L11, J_m2_L12, J_m2_L13, J_m2_L14_end];
J_m2_L = simplify(J_m2_L);

J_m2_A = [J_m2_A1_A3, J_m2_A4_A11, J_m2_A12, J_m2_A13, J_m2_A14_end];
J_m2_A = simplify(J_m2_A);

M_m2 = m_m2*(J_m2_L.'*J_m2_L) + J_m2_A.'*I_cm2*J_m2_A;

% Mass matrix contribution of third link of middle finger
disp("Computing mass matrix contribution of third link of middle finger...")
z_m2 = R_m2*[0; 0; 1];

m0_p_m0m2 = [(l_m1 + l_m2*cos(q_m2))*cos(q_m1);
             (l_m1 + l_m2*cos(q_m2))*sin(q_m1);
                                l_m2*sin(q_m2)];
p_w0m2 = simplify(R_m0*m0_p_m0m2 + p_w0m0);

c_m2m3 = cos(q_m2 + q_m3);
s_m2m3 = sin(q_m2 + q_m3);
m0_r_cm3 = [(l_m1 + l_m2*cos(q_m2) + (l_m3/2)*c_m2m3)*cos(q_m1);
            (l_m1 + l_m2*cos(q_m2) + (l_m3/2)*c_m2m3)*sin(q_m1);
                               l_m2*sin(q_m2) + (l_m3/2)*s_m2m3];
r_cm3 = simplify(R_m0*m0_r_cm3 + p_w0m0);

R_m3 = simplify(R_m2*R_z(q_m3));
I_cm3 = link_inertia(m_m3, f_radius, l_m3, R_m3);
I_cm3 = simplify(I_cm3);

J_m3_L1 = simplify(cross(z_w0, r_cm3 - p_w0w0));
J_m3_L2 = simplify(cross(z_w1, r_cm3 - p_w0w1));
J_m3_L3 = simplify(cross(z_w2, r_cm3 - p_w0w2));
J_m3_L1_L3 = [J_m3_L1, J_m3_L2, J_m3_L3];
J_m3_L4_L11 = zeros(3, 8);
J_m3_L12 = simplify(cross(z_m0, r_cm3 - p_w0m0));
J_m3_L13 = simplify(cross(z_m1, r_cm3 - p_w0m1));
J_m3_L14 = simplify(cross(z_m2, r_cm3 - p_w0m2));
J_m3_L15_end = zeros(3, 9);

J_m3_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_m3_A4_A11 = zeros(3, 8);
J_m3_A12 = z_m0;
J_m3_A13 = z_m1;
J_m3_A14 = z_m2;
J_m3_A15_end = zeros(3, 9);

J_m3_L = [J_m3_L1_L3, J_m3_L4_L11, J_m3_L12, J_m3_L13, J_m3_L14, J_m3_L15_end];
J_m3_L = simplify(J_m3_L);

J_m3_A = [J_m3_A1_A3, J_m3_A4_A11, J_m3_A12, J_m3_A13, J_m3_A14, J_m3_A15_end];
J_m3_A = simplify(J_m3_A);

M_m3 = m_m3*(J_m3_L.'*J_m3_L) + J_m3_A.'*I_cm3*J_m3_A;

% Mass matrix contribution of fourth link of middle finger
disp("Computing mass matrix contribution of fourth link of middle finger...")
z_m3 = R_m3*[0; 0; 1];

m0_p_m0m3 = [(l_m1 + l_m2*cos(q_m2) + l_m3*c_m2m3)*cos(q_m1);
             (l_m1 + l_m2*cos(q_m2) + l_m3*c_m2m3)*sin(q_m1);
                                l_m2*sin(q_m2) + l_m3*s_m2m3];
p_w0m3 = simplify(R_m0*m0_p_m0m3 + p_w0m0);

c_m2m3m4 = cos(q_m2 + q_m3 + q_m4);
s_m2m3m4 = sin(q_m2 + q_m3 + q_m4);
m0_r_cm4 = [(l_m1 + l_m2*cos(q_m2) + l_m3*c_m2m3 + (l_m4/2)*c_m2m3m4)*cos(q_m1);
            (l_m1 + l_m2*cos(q_m2) + l_m3*c_m2m3 + (l_m4/2)*c_m2m3m4)*sin(q_m1);
                               l_m2*sin(q_m2) + l_m3*s_m2m3 + (l_m4/2)*s_m2m3m4];
r_cm4 = simplify(R_m0*m0_r_cm4 + p_w0m0);

R_m4 = simplify(R_m3*R_z(q_m4)*R_x(-sym(pi)/2));
I_cm4 = link_inertia(m_m4, f_radius, l_m4, R_m4);
I_cm4 = simplify(I_cm4);

J_m4_L1 = simplify(cross(z_w0, r_cm4 - p_w0w0));
J_m4_L2 = simplify(cross(z_w1, r_cm4 - p_w0w1));
J_m4_L3 = simplify(cross(z_w2, r_cm4 - p_w0w2));
J_m4_L1_L3 = [J_m4_L1, J_m4_L2, J_m4_L3];
J_m4_L4_L11 = zeros(3, 8);
J_m4_L12 = simplify(cross(z_m0, r_cm4 - p_w0m0));
J_m4_L13 = simplify(cross(z_m1, r_cm4 - p_w0m1));
J_m4_L14 = simplify(cross(z_m2, r_cm4 - p_w0m2));
J_m4_L15 = simplify(cross(z_m3, r_cm4 - p_w0m3));
J_m4_L16_end = zeros(3, 8);

J_m4_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_m4_A4_A11 = zeros(3, 8);
J_m4_A12 = z_m0;
J_m4_A13 = z_m1;
J_m4_A14 = z_m2;
J_m4_A15 = z_m3;
J_m4_A16_end = zeros(3, 8);

J_m4_L = [J_m4_L1_L3, J_m4_L4_L11, J_m4_L12, J_m4_L13, J_m4_L14, J_m4_L15, J_m4_L16_end];
J_m4_L = simplify(J_m4_L);

J_m4_A = [J_m4_A1_A3, J_m4_A4_A11, J_m4_A12, J_m4_A13, J_m4_A14, J_m4_A15, J_m4_A16_end];
J_m4_A = simplify(J_m4_A);

M_m4 = m_m4*(J_m4_L.'*J_m4_L) + J_m4_A.'*I_cm4*J_m4_A;

% Total mass matrix contribution of middle finger
disp("Computing total mass matrix contribution of middle finger...")
M_m = M_m1 + M_m2 + M_m3 + M_m4;

% Mass matrix contribution of first link of ring finger
disp("Computing mass matrix contribution of first link of ring finger...")
p_w0r0 = simplify(R_w3*[a_p; 0; -d_p/3] + p_w0w1);
R_r0 = R_w3*R_x(-sym(pi)/2);

r0_z_r0 = eye(3)*[0; 0; 1];
z_r0 = simplify(R_r0*r0_z_r0);

r0_r_cr1 = [(l_r1/2)*cos(q_r1);
            (l_r1/2)*sin(q_r1);
                             0];
r_cr1 = simplify(R_r0*r0_r_cr1 + p_w0r0);

r0_R_r1 = R_z(q_r1)*R_x(sym(pi)/2);
R_r1 = simplify(R_r0*r0_R_r1);
I_cr1 = link_inertia(m_r1, f_radius, l_r1, R_r1);
I_cr1 = simplify(I_cr1);

J_r1_L1 = simplify(cross(z_w0, r_cr1 - p_w0w0));
J_r1_L2 = simplify(cross(z_w1, r_cr1 - p_w0w1));
J_r1_L3 = simplify(cross(z_w2, r_cr1 - p_w0w2));
J_r1_L1_L3 = [J_r1_L1, J_r1_L2, J_r1_L3];
J_r1_L4_L15 = zeros(3, 12);
J_r1_L16 = simplify(cross(z_r0, r_cr1 - p_w0r0));
J_r1_L17_end = zeros(3, 7);

J_r1_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_r1_A4_A15 = zeros(3, 12);
J_r1_A16 = z_r0;
J_r1_A17_end = zeros(3, 7);

J_r1_L = [J_r1_L1_L3, J_r1_L4_L15, J_r1_L16, J_r1_L17_end];
J_r1_L = simplify(J_r1_L);

J_r1_A = [J_r1_A1_A3, J_r1_A4_A15, J_r1_A16, J_r1_A17_end];
J_r1_A = simplify(J_r1_A);

M_r1 = m_r1*(J_r1_L.'*J_r1_L) + J_r1_A.'*I_cr1*J_r1_A;

% Mass matrix contribution of second link of ring finger
disp("Computing mass matrix contribution of second link of ring finger...")
z_r1 = R_r1*[0; 0; 1];

r0_p_r0r1 = [l_r1*cos(q_r1);
             l_r1*sin(q_r1);
                          0];
p_w0r1 = simplify(R_r0*r0_p_r0r1 + p_w0r0);

r0_r_cr2 = [(l_r1 + (l_r2/2)*cos(q_r2))*cos(q_r1);
            (l_r1 + (l_r2/2)*cos(q_r2))*sin(q_r1);
                               (l_r2/2)*sin(q_r2)];
r_cr2 = simplify(R_r0*r0_r_cr2 + p_w0r0);

R_r2 = simplify(R_r1*R_z(q_r2));
I_cr2 = link_inertia(m_r2, f_radius, l_r2, R_r2);
I_cr2 = simplify(I_cr2);

J_r2_L1 = simplify(cross(z_w0, r_cr2 - p_w0w0));
J_r2_L2 = simplify(cross(z_w1, r_cr2 - p_w0w1));
J_r2_L3 = simplify(cross(z_w2, r_cr2 - p_w0w2));
J_r2_L1_L3 = [J_r2_L1, J_r2_L2, J_r2_L3];
J_r2_L4_L15 = zeros(3, 12);
J_r2_L16 = simplify(cross(z_r0, r_cr2 - p_w0r0));
J_r2_L17 = simplify(cross(z_r1, r_cr2 - p_w0r1));
J_r2_L18_end = zeros(3, 6);

J_r2_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_r2_A4_A15 = zeros(3, 12);
J_r2_A16 = z_r0;
J_r2_A17 = z_r1;
J_r2_A18_end = zeros(3, 6);

J_r2_L = [J_r2_L1_L3, J_r2_L4_L15, J_r2_L16, J_r2_L17, J_r2_L18_end];
J_r2_L = simplify(J_r2_L);

J_r2_A = [J_r2_A1_A3, J_r2_A4_A15, J_r2_A16, J_r2_A17, J_r2_A18_end];
J_r2_A = simplify(J_r2_A);

M_r2 = m_r2*(J_r2_L.'*J_r2_L) + J_r2_A.'*I_cr2*J_r2_A;

% Mass matrix contribution of third link of ring finger
disp("Computing mass matrix contribution of third link of ring finger...")
z_r2 = R_r2*[0; 0; 1];

r0_p_r0r2 = [(l_r1 + l_r2*cos(q_r2))*cos(q_r1);
             (l_r1 + l_r2*cos(q_r2))*sin(q_r1);
                                l_r2*sin(q_r2)];
p_w0r2 = simplify(R_r0*r0_p_r0r2 + p_w0r0);

c_r2r3 = cos(q_r2 + q_r3);
s_r2r3 = sin(q_r2 + q_r3);
r0_r_cr3 = [(l_r1 + l_r2*cos(q_r2) + (l_r3/2)*c_r2r3)*cos(q_r1);
            (l_r1 + l_r2*cos(q_r2) + (l_r3/2)*c_r2r3)*sin(q_r1);
                               l_r2*sin(q_r2) + (l_r3/2)*s_r2r3];
r_cr3 = simplify(R_r0*r0_r_cr3 + p_w0r0);

R_r3 = simplify(R_r2*R_z(q_r3));
I_cr3 = link_inertia(m_r3, f_radius, l_r3, R_r3);
I_cr3 = simplify(I_cr3);

J_r3_L1 = simplify(cross(z_w0, r_cr3 - p_w0w0));
J_r3_L2 = simplify(cross(z_w1, r_cr3 - p_w0w1));
J_r3_L3 = simplify(cross(z_w2, r_cr3 - p_w0w2));
J_r3_L1_L3 = [J_r3_L1, J_r3_L2, J_r3_L3];
J_r3_L4_L15 = zeros(3, 12);
J_r3_L16 = simplify(cross(z_r0, r_cr3 - p_w0r0));
J_r3_L17 = simplify(cross(z_r1, r_cr3 - p_w0r1));
J_r3_L18 = simplify(cross(z_r2, r_cr3 - p_w0r2));
J_r3_L19_end = zeros(3, 5);

J_r3_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_r3_A4_A15 = zeros(3, 12);
J_r3_A16 = z_r0;
J_r3_A17 = z_r1;
J_r3_A18 = z_r2;
J_r3_A19_end = zeros(3, 5);

J_r3_L = [J_r3_L1_L3, J_r3_L4_L15, J_r3_L16, J_r3_L17, J_r3_L18, J_r3_L19_end];
J_r3_L = simplify(J_r3_L);

J_r3_A = [J_r3_A1_A3, J_r3_A4_A15, J_r3_A16, J_r3_A17, J_r3_A18, J_r3_A19_end];
J_r3_A = simplify(J_r3_A);

M_r3 = m_r3*(J_r3_L.'*J_r3_L) + J_r3_A.'*I_cr3*J_r3_A;

% Mass matrix contribution of fourth link of ring finger
disp("Computing mass matrix contribution of fourth link of ring finger...")
z_r3 = R_r3*[0; 0; 1];

r0_p_r0r3 = [(l_r1 + l_r2*cos(q_r2) + l_r3*c_r2r3)*cos(q_r1);
             (l_r1 + l_r2*cos(q_r2) + l_r3*c_r2r3)*sin(q_r1);
                                l_r2*sin(q_r2) + l_r3*s_r2r3];
p_w0r3 = simplify(R_r0*r0_p_r0r3 + p_w0r0);

c_r2r3r4 = cos(q_r2 + q_r3 + q_r4);
s_r2r3r4 = sin(q_r2 + q_r3 + q_r4);
r0_r_cr4 = [(l_r1 + l_r2*cos(q_r2) + l_r3*c_r2r3 + (l_r4/2)*c_r2r3r4)*cos(q_r1);
            (l_r1 + l_r2*cos(q_r2) + l_r3*c_r2r3 + (l_r4/2)*c_r2r3r4)*sin(q_r1);
                               l_r2*sin(q_r2) + l_r3*s_r2r3 + (l_r4/2)*s_r2r3r4];
r_cr4 = simplify(R_r0*r0_r_cr4 + p_w0r0);

R_r4 = simplify(R_r3*R_z(q_r4)*R_x(-sym(pi)/2));
I_cr4 = link_inertia(m_r4, f_radius, l_r4, R_r4);
I_cr4 = simplify(I_cr4);

J_r4_L1 = simplify(cross(z_w0, r_cr4 - p_w0w0));
J_r4_L2 = simplify(cross(z_w1, r_cr4 - p_w0w1));
J_r4_L3 = simplify(cross(z_w2, r_cr4 - p_w0w2));
J_r4_L1_L3 = [J_r4_L1, J_r4_L2, J_r4_L3];
J_r4_L4_L15 = zeros(3, 12);
J_r4_L16 = simplify(cross(z_r0, r_cr4 - p_w0r0));
J_r4_L17 = simplify(cross(z_r1, r_cr4 - p_w0r1));
J_r4_L18 = simplify(cross(z_r2, r_cr4 - p_w0r2));
J_r4_L19 = simplify(cross(z_r3, r_cr4 - p_w0r3));
J_r4_L20_end = zeros(3, 4);

J_r4_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_r4_A4_A15 = zeros(3, 12);
J_r4_A16 = z_r0;
J_r4_A17 = z_r1;
J_r4_A18 = z_r2;
J_r4_A19 = z_r3;
J_r4_A20_end = zeros(3, 4);

J_r4_L = [J_r4_L1_L3, J_r4_L4_L15, J_r4_L16, J_r4_L17, J_r4_L18, J_r4_L19, J_r4_L20_end];
J_r4_L = simplify(J_r4_L);

J_r4_A = [J_r4_A1_A3, J_r4_A4_A15, J_r4_A16, J_r4_A17, J_r4_A18, J_r4_A19, J_r4_A20_end];
J_r4_A = simplify(J_r4_A);

M_r4 = m_r4*(J_r4_L.'*J_r4_L) + J_r4_A.'*I_cr4*J_r4_A;

% Total mass matrix contribution of ring finger
disp("Computing total mass matrix contribution of ring finger...")
M_r = M_r1 + M_r2 + M_r3 + M_r4;

% Mass matrix contribution of first link of little finger
disp("Computing mass matrix contribution of first link of little finger...")
p_w0l0 = simplify(R_w3*[a_p; 0; -2*d_p/3] + p_w0w1);
R_l0 = R_w3*R_x(-sym(pi)/2);

l0_z_l0 = eye(3)*[0; 0; 1];
z_l0 = simplify(R_l0*l0_z_l0);

l0_r_cl1 = [(l_l1/2)*cos(q_l1);
            (l_l1/2)*sin(q_l1);
                             0];
r_cl1 = simplify(R_l0*l0_r_cl1 + p_w0l0);

l0_R_l1 = R_z(q_l1)*R_x(sym(pi)/2);
R_l1 = simplify(R_l0*l0_R_l1);
I_cl1 = link_inertia(m_l1, f_radius, l_l1, R_l1);
I_cl1 = simplify(I_cl1);

J_l1_L1 = simplify(cross(z_w0, r_cl1 - p_w0w0));
J_l1_L2 = simplify(cross(z_w1, r_cl1 - p_w0w1));
J_l1_L3 = simplify(cross(z_w2, r_cl1 - p_w0w2));
J_l1_L1_L3 = [J_l1_L1, J_l1_L2, J_l1_L3];
J_l1_L4_L19 = zeros(3, 16);
J_l1_L20 = simplify(cross(z_l0, r_cl1 - p_w0l0));
J_l1_L21_end = zeros(3, 3);

J_l1_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_l1_A4_A19 = zeros(3, 16);
J_l1_A20 = z_l0;
J_l1_A21_end = zeros(3, 3);

J_l1_L = [J_l1_L1_L3, J_l1_L4_L19, J_l1_L20, J_l1_L21_end];
J_l1_L = simplify(J_l1_L);

J_l1_A = [J_l1_A1_A3, J_l1_A4_A19, J_l1_A20, J_l1_A21_end];
J_l1_A = simplify(J_l1_A);

M_l1 = m_l1*(J_l1_L.'*J_l1_L) + J_l1_A.'*I_cl1*J_l1_A;

% Mass matrix contribution of second link of little finger
disp("Computing mass matrix contribution of second link of little finger...")
z_l1 = R_l1*[0; 0; 1];

l0_p_l0l1 = [l_l1*cos(q_l1);
             l_l1*sin(q_l1);
                          0];
p_w0l1 = simplify(R_l0*l0_p_l0l1 + p_w0l0);

l0_r_cl2 = [(l_l1 + (l_l2/2)*cos(q_l2))*cos(q_l1);
            (l_l1 + (l_l2/2)*cos(q_l2))*sin(q_l1);
                               (l_l2/2)*sin(q_l2)];
r_cl2 = simplify(R_l0*l0_r_cl2 + p_w0l0);

R_l2 = simplify(R_l1*R_z(q_l2));
I_cl2 = link_inertia(m_l2, f_radius, l_l2, R_l2);
I_cl2 = simplify(I_cl2);

J_l2_L1 = simplify(cross(z_w0, r_cl2 - p_w0w0));
J_l2_L2 = simplify(cross(z_w1, r_cl2 - p_w0w1));
J_l2_L3 = simplify(cross(z_w2, r_cl2 - p_w0w2));
J_l2_L1_L3 = [J_l2_L1, J_l2_L2, J_l2_L3];
J_l2_L4_L19 = zeros(3, 16);
J_l2_L20 = simplify(cross(z_l0, r_cl2 - p_w0l0));
J_l2_L21 = simplify(cross(z_l1, r_cl2 - p_w0l1));
J_l2_L22_end = zeros(3, 2);

J_l2_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_l2_A4_A19 = zeros(3, 16);
J_l2_A20 = z_l0;
J_l2_A21 = z_l1;
J_l2_A22_end = zeros(3, 2);

J_l2_L = [J_l2_L1_L3, J_l2_L4_L19, J_l2_L20, J_l2_L21, J_l2_L22_end];
J_l2_L = simplify(J_l2_L);

J_l2_A = [J_l2_A1_A3, J_l2_A4_A19, J_l2_A20, J_l2_A21, J_l2_A22_end];
J_l2_A = simplify(J_l2_A);

M_l2 = m_l2*(J_l2_L.'*J_l2_L) + J_l2_A.'*I_cl2*J_l2_A;

% Mass matrix contribution of third link of little finger
disp("Computing mass matrix contribution of third link of little finger...")
z_l2 = R_l2*[0; 0; 1];

l0_p_l0l2 = [(l_l1 + l_l2*cos(q_l2))*cos(q_l1);
             (l_l1 + l_l2*cos(q_l2))*sin(q_l1);
                                l_l2*sin(q_l2)];
p_w0l2 = simplify(R_l0*l0_p_l0l2 + p_w0l0);

c_l2l3 = cos(q_l2 + q_l3);
s_l2l3 = sin(q_l2 + q_l3);
l0_r_cl3 = [(l_l1 + l_l2*cos(q_l2) + (l_l3/2)*c_l2l3)*cos(q_l1);
            (l_l1 + l_l2*cos(q_l2) + (l_l3/2)*c_l2l3)*sin(q_l1);
                               l_l2*sin(q_l2) + (l_l3/2)*s_l2l3];
r_cl3 = simplify(R_l0*l0_r_cl3 + p_w0l0);

R_l3 = simplify(R_l2*R_z(q_l3));
I_cl3 = link_inertia(m_l3, f_radius, l_l3, R_l3);
I_cl3 = simplify(I_cl3);

J_l3_L1 = simplify(cross(z_w0, r_cl3 - p_w0w0));
J_l3_L2 = simplify(cross(z_w1, r_cl3 - p_w0w1));
J_l3_L3 = simplify(cross(z_w2, r_cl3 - p_w0w2));
J_l3_L1_L3 = [J_l3_L1, J_l3_L2, J_l3_L3];
J_l3_L4_L19 = zeros(3, 16);
J_l3_L20 = simplify(cross(z_l0, r_cl3 - p_w0l0));
J_l3_L21 = simplify(cross(z_l1, r_cl3 - p_w0l1));
J_l3_L22 = simplify(cross(z_l2, r_cl3 - p_w0l2));
J_l3_L23 = zeros(3, 1);

J_l3_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_l3_A4_A19 = zeros(3, 16);
J_l3_A20 = z_l0;
J_l3_A21 = z_l1;
J_l3_A22 = z_l2;
J_l3_A23 = zeros(3, 1);

J_l3_L = [J_l3_L1_L3, J_l3_L4_L19, J_l3_L20, J_l3_L21, J_l3_L22, J_l3_L23];
J_l3_L = simplify(J_l3_L);

J_l3_A = [J_l3_A1_A3, J_l3_A4_A19, J_l3_A20, J_l3_A21, J_l3_A22, J_l3_A23];
J_l3_A = simplify(J_l3_A);

M_l3 = m_l3*(J_l3_L.'*J_l3_L) + J_l3_A.'*I_cl3*J_l3_A;

% Mass matrix contribution of fourth link of little finger
disp("Computing mass matrix contribution of fourth link of little finger...")
z_l3 = R_l3*[0; 0; 1];

l0_p_l0l3 = [(l_l1 + l_l2*cos(q_l2) + l_l3*c_l2l3)*cos(q_l1);
             (l_l1 + l_l2*cos(q_l2) + l_l3*c_l2l3)*sin(q_l1);
                                l_l2*sin(q_l2) + l_l3*s_l2l3];
p_w0l3 = simplify(R_l0*l0_p_l0l3 + p_w0l0);

c_l2l3l4 = cos(q_l2 + q_l3 + q_l4);
s_l2l3l4 = sin(q_l2 + q_l3 + q_l4);
l0_r_cl4 = [(l_l1 + l_l2*cos(q_l2) + l_l3*c_l2l3 + (l_l4/2)*c_l2l3l4)*cos(q_l1);
            (l_l1 + l_l2*cos(q_l2) + l_l3*c_l2l3 + (l_l4/2)*c_l2l3l4)*sin(q_l1);
                               l_l2*sin(q_l2) + l_l3*s_l2l3 + (l_l4/2)*s_l2l3l4];
r_cl4 = simplify(R_l0*l0_r_cl4 + p_w0l0);

R_l4 = simplify(R_l3*R_z(q_l4)*R_x(-sym(pi)/2));
I_cl4 = link_inertia(m_l4, f_radius, l_l4, R_l4);
I_cl4 = simplify(I_cl4);

J_l4_L1 = simplify(cross(z_w0, r_cl4 - p_w0w0));
J_l4_L2 = simplify(cross(z_w1, r_cl4 - p_w0w1));
J_l4_L3 = simplify(cross(z_w2, r_cl4 - p_w0w2));
J_l4_L1_L3 = [J_l4_L1, J_l4_L2, J_l4_L3];
J_l4_L4_L19 = zeros(3, 16);
J_l4_L20 = simplify(cross(z_l0, r_cl4 - p_w0l0));
J_l4_L21 = simplify(cross(z_l1, r_cl4 - p_w0l1));
J_l4_L22 = simplify(cross(z_l2, r_cl4 - p_w0l2));
J_l4_L23 = simplify(cross(z_l3, r_cl4 - p_w0l3));

J_l4_A1_A3 = [J_w3_A1, J_w3_A2, J_w3_A3];
J_l4_A4_A19 = zeros(3, 16);
J_l4_A20 = z_l0;
J_l4_A21 = z_l1;
J_l4_A22 = z_l2;
J_l4_A23 = z_l3;

J_l4_L = [J_l4_L1_L3, J_l4_L4_L19, J_l4_L20, J_l4_L21, J_l4_L22, J_l4_L23];
J_l4_L = simplify(J_l4_L);

J_l4_A = [J_l4_A1_A3, J_l4_A4_A19, J_l4_A20, J_l4_A21, J_l4_A22, J_l4_A23];
J_l4_A = simplify(J_l4_A);

M_l4 = m_l4*(J_l4_L.'*J_l4_L) + J_l4_A.'*I_cl4*J_l4_A;

% Total mass matrix contribution of little finger
disp("Computing total mass matrix contribution of little finger...")
M_l = M_l1 + M_l2 + M_l3 + M_l4;

% Mass matrix of whole hand
disp("Computing mass matrix of whole hand...")
M = M_w + M_t + M_i + M_m + M_r + M_l;

% Time necessary to compute mass matrix
T_M = toc;
disp(['Mass matrix of whole hand computed in ', num2str(T_M), ' seconds.'])

%-------------------------------------------------------------------------------
% MATRIX "C" (RELATED TO CENTRIFUGAL AND CORIOLIS FORCES)
%-------------------------------------------------------------------------------

tic;

C = sym(zeros(size(M)));
for i = 1:size(C, 1)
    for j = 1:size(C, 2)
        c_ij = 0;
        for k = 1:size(C, 1)
            disp(['Computing Christoffel symbol (', num2str(i), ', ', num2str(j), ', ', num2str(k), ')...'])
            c_ijk = (1/2)*diff(M(i, j), q(k));
            c_ijk = c_ijk + (1/2)*diff(M(i, k), q(j));
            c_ijk = c_ijk - (1/2)*diff(M(j, k), q(i));
            c_ij = c_ij + c_ijk*q_dot(k);
        end
        C(i, j) = c_ij;
    end
end

% Time necessary to compute matrix "C" (related to centrifugal and Coriolis forces)
T_C = toc;
disp(['Matrix "C" (related to centrifugal and Coriolis forces) computed in ', num2str(T_C), ' seconds.'])

%-------------------------------------------------------------------------------
% POTENTIAL ENERGY
%-------------------------------------------------------------------------------

tic;

% Gravity vector
g_0 = 9.81;
g = [0; -g_0; 0];

% Potential energy of first link of wrist
disp("Computing potential energy of first link of wrist...")
U_w1 = -m_w1*g.'*r_cw1;

% Potential energy of second link of wrist
disp("Computing potential energy of second link of wrist...")
U_w2 = -m_w2*g.'*r_cw2;

% Potential energy of third link of wrist (i.e. the palm)
disp("Computing potential energy of third link of wrist (i.e. the palm)...")
U_w3 = -m_p*g.'*r_cw3;

% Total potential energy of wrist
disp("Simplifying total potential energy of wrist...")
U_w = U_w1 + U_w2 + U_w3;
U_w = simplify(U_w);

% Potential energy of first link of thumb
disp("Computing potential energy of first link of thumb...")
U_t1_g = -m_t1*g.'*r_ct1;
U_t1_e = (sym(1)/2)*k_t1*(q_t1 - k_t1_0)^2;

% Potential energy of second link of thumb
disp("Computing potential energy of second link of thumb...")
U_t2_g = -m_t2*g.'*r_ct2;
U_t2_e = (sym(1)/2)*k_t2*(q_t2 - k_t2_0)^2;

% Potential energy of third link of thumb
disp("Computing potential energy of third link of thumb...")
U_t3_g = -m_t3*g.'*r_ct3;
U_t3_e = (sym(1)/2)*k_t3*(q_t3 - k_t3_0)^2;

% Potential energy of fourth link of thumb
disp("Computing potential energy of fourth link of thumb...")
U_t4_g = -m_t4*g.'*r_ct4;
U_t4_e = (sym(1)/2)*k_t4*(q_t4 - k_t4_0)^2;

% Total potential energy of thumb
disp("Simplifying total potential energy of thumb...")
U_t_g = U_t1_g + U_t2_g + U_t3_g + U_t4_g;
U_t_g = simplify(U_t_g);
U_t_e = U_t1_e + U_t2_e + U_t3_e + U_t4_e;
U_t_e = simplify(U_t_e);

% Potential energy of first link of index finger
disp("Computing potential energy of first link of index finger...")
U_i1_g = -m_i1*g.'*r_ci1;
U_i1_e = (sym(1)/2)*k_i1*(q_i1 - k_i1_0)^2;

% Potential energy of second link of index finger
disp("Computing potential energy of second link of index finger...")
U_i2_g = -m_i2*g.'*r_ci2;
U_i2_e = (sym(1)/2)*k_i2*(q_i2 - k_i2_0)^2;

% Potential energy of third link of index finger
disp("Computing potential energy of third link of index finger...")
U_i3_g = -m_i3*g.'*r_ci3;
U_i3_e = (sym(1)/2)*k_i3*(q_i3 - k_i3_0)^2;

% Potential energy of fourth link of index finger
disp("Computing potential energy of fourth link of index finger...")
U_i4_g = -m_i4*g.'*r_ci4;
U_i4_e = (sym(1)/2)*k_i4*(q_i4 - k_i4_0)^2;

% Total potential energy of index finger
disp("Simplifying total potential energy of index finger...")
U_i_g = U_i1_g + U_i2_g + U_i3_g + U_i4_g;
U_i_g = simplify(U_i_g);
U_i_e = U_i1_e + U_i2_e + U_i3_e + U_i4_e;
U_i_e = simplify(U_i_e);

% Potential energy of first link of middle finger
disp("Computing potential energy of first link of middle finger...")
U_m1_g = -m_m1*g.'*r_cm1;
U_m1_e = (sym(1)/2)*k_m1*(q_m1 - k_m1_0)^2;

% Potential energy of second link of middle finger
disp("Computing potential energy of second link of middle finger...")
U_m2_g = -m_m2*g.'*r_cm2;
U_m2_e = (sym(1)/2)*k_m2*(q_m2 - k_m2_0)^2;

% Potential energy of third link of middle finger
disp("Computing potential energy of third link of middle finger...")
U_m3_g = -m_m3*g.'*r_cm3;
U_m3_e = (sym(1)/2)*k_m3*(q_m3 - k_m3_0)^2;

% Potential energy of fourth link of middle finger
disp("Computing potential energy of fourth link of middle finger...")
U_m4_g = -m_m4*g.'*r_cm4;
U_m4_e = (sym(1)/2)*k_m4*(q_m4 - k_m4_0)^2;

% Total potential energy of middle finger
disp("Simplifying total potential energy of middle finger...")
U_m_g = U_m1_g + U_m2_g + U_m3_g + U_m4_g;
U_m_g = simplify(U_m_g);
U_m_e = U_m1_e + U_m2_e + U_m3_e + U_m4_e;
U_m_e = simplify(U_m_e);

% Potential energy of first link of ring finger
disp("Computing potential energy of first link of ring finger...")
U_r1_g = -m_r1*g.'*r_cr1;
U_r1_e = (sym(1)/2)*k_r1*(q_r1 - k_r1_0)^2;

% Potential energy of second link of ring finger
disp("Computing potential energy of second link of ring finger...")
U_r2_g = -m_r2*g.'*r_cr2;
U_r2_e = (sym(1)/2)*k_r2*(q_r2 - k_r2_0)^2;

% Potential energy of third link of ring finger
disp("Computing potential energy of third link of ring finger...")
U_r3_g = -m_r3*g.'*r_cr3;
U_r3_e = (sym(1)/2)*k_r3*(q_r3 - k_r3_0)^2;

% Potential energy of fourth link of ring finger
disp("Computing potential energy of fourth link of ring finger...")
U_r4_g = -m_r4*g.'*r_cr4;
U_r4_e = (sym(1)/2)*k_r4*(q_r4 - k_r4_0)^2;

% Total potential energy of ring finger
disp("Simplifying total potential energy of ring finger...")
U_r_g = U_r1_g + U_r2_g + U_r3_g + U_r4_g;
U_r_g = simplify(U_r_g);
U_r_e = U_r1_e + U_r2_e + U_r3_e + U_r4_e;
U_r_e = simplify(U_r_e);

% Potential energy of first link of little finger
disp("Computing potential energy of first link of little finger...")
U_l1_g = -m_l1*g.'*r_cl1;
U_l1_e = (sym(1)/2)*k_l1*(q_l1 - k_l1_0)^2;

% Potential energy of second link of little finger
disp("Computing potential energy of second link of little finger...")
U_l2_g = -m_l2*g.'*r_cl2;
U_l2_e = (sym(1)/2)*k_l2*(q_l2 - k_l2_0)^2;

% Potential energy of third link of little finger
disp("Computing potential energy of third link of little finger...")
U_l3_g = -m_l3*g.'*r_cl3;
U_l3_e = (sym(1)/2)*k_l3*(q_l3 - k_l3_0)^2;

% Potential energy of fourth link of little finger
disp("Computing potential energy of fourth link of little finger...")
U_l4_g = -m_l4*g.'*r_cl4;
U_l4_e = (sym(1)/2)*k_l4*(q_l4 - k_l4_0)^2;

% Total potential energy of little finger
disp("Simplifying total potential energy of little finger...")
U_l_g = U_l1_g + U_l2_g + U_l3_g + U_l4_g;
U_l_g = simplify(U_l_g);
U_l_e = U_l1_e + U_l2_e + U_l3_e + U_l4_e;
U_l_e = simplify(U_l_e);

% Total potential energy of whole hand
disp("Simplifying potential energy of whole hand...")
U_g = U_w + U_t_g + U_i_g + U_m_g + U_r_g + U_l_g;
U_g = simplify(U_g);
U_e = U_t_e + U_i_e + U_m_e + U_r_e + U_l_e;
U_e = simplify(U_e);

% Time necessary to compute potential energy
T_U = toc;
disp(['Potential energy of whole hand computed in ', num2str(T_U), ' seconds.'])

%-------------------------------------------------------------------------------
% GRAVITATIONAL FORCES
%-------------------------------------------------------------------------------

tic;

% Gravitational forces acting on wrist
disp("Computing gravitational forces acting on wrist...")
F_g_w1 = diff(U_g, q_w1);
F_g_w2 = diff(U_g, q_w2);
F_g_w3 = diff(U_g, q_w3);
F_g_w = [F_g_w1; 
         F_g_w2; 
         F_g_w3];

% Gravitational forces acting on thumb
disp("Computing gravitational forces acting on thumb...")
F_g_t1 = diff(U_g, q_t1);
F_g_t2 = diff(U_g, q_t2);
F_g_t3 = diff(U_g, q_t3);
F_g_t4 = diff(U_g, q_t4);
F_g_t = [F_g_t1; 
         F_g_t2; 
         F_g_t3; 
         F_g_t4];

% Gravitational forces acting on index finger
disp("Computing gravitational forces acting on index finger...")
F_g_i1 = diff(U_g, q_i1);
F_g_i2 = diff(U_g, q_i2);
F_g_i3 = diff(U_g, q_i3);
F_g_i4 = diff(U_g, q_i4);
F_g_i = [F_g_i1; 
         F_g_i2; 
         F_g_i3; 
         F_g_i4];

% Gravitational forces acting on middle finger
disp("Computing gravitational forces acting on middle finger...")
F_g_m1 = diff(U_g, q_m1);
F_g_m2 = diff(U_g, q_m2);
F_g_m3 = diff(U_g, q_m3);
F_g_m4 = diff(U_g, q_m4);
F_g_m = [F_g_m1; 
         F_g_m2; 
         F_g_m3; 
         F_g_m4];

% Gravitational forces acting on ring finger
disp("Computing gravitational forces acting on ring finger...")
F_g_r1 = diff(U_g, q_r1);
F_g_r2 = diff(U_g, q_r2);
F_g_r3 = diff(U_g, q_r3);
F_g_r4 = diff(U_g, q_r4);
F_g_r = [F_g_r1; 
         F_g_r2; 
         F_g_r3; 
         F_g_r4];

% Gravitational forces acting on little finger
disp("Computing gravitational forces acting on little finger...")
F_g_l1 = diff(U_g, q_l1);
F_g_l2 = diff(U_g, q_l2);
F_g_l3 = diff(U_g, q_l3);
F_g_l4 = diff(U_g, q_l4);
F_g_l = [F_g_l1; 
         F_g_l2; 
         F_g_l3; 
         F_g_l4];

% Vector of gravitational forces
F_g = [F_g_w; 
       F_g_t; 
       F_g_i; 
       F_g_m; 
       F_g_r; 
       F_g_l];

% Time necessary to compute gravitational forces
T_G = toc;
disp(['Gravitational forces computed in ', num2str(T_G), ' seconds.'])

%-------------------------------------------------------------------------------
% ELASTIC FORCES
%-------------------------------------------------------------------------------

tic;

% Elastic forces acting on wrist (must be zero)
disp("Computing elastic forces acting on wrist (must be zero)...")
F_e_w1 = diff(U_e, q_w1);
F_e_w2 = diff(U_e, q_w2);
F_e_w3 = diff(U_e, q_w3);
F_e_w = [F_e_w1; 
         F_e_w2; 
         F_e_w3];

% Elastic forces acting on thumb
disp("Computing elastic forces acting on thumb...")
F_e_t1 = diff(U_e, q_t1);
F_e_t2 = diff(U_e, q_t2);
F_e_t3 = diff(U_e, q_t3);
F_e_t4 = diff(U_e, q_t4);
F_e_t = [F_e_t1; 
         F_e_t2; 
         F_e_t3; 
         F_e_t4];

% Elastic forces acting on index finger
disp("Computing elastic forces acting on index finger...")
F_e_i1 = diff(U_e, q_i1);
F_e_i2 = diff(U_e, q_i2);
F_e_i3 = diff(U_e, q_i3);
F_e_i4 = diff(U_e, q_i4);
F_e_i = [F_e_i1; 
         F_e_i2; 
         F_e_i3; 
         F_e_i4];

% Elastic forces acting on middle finger
disp("Computing elastic forces acting on middle finger...")
F_e_m1 = diff(U_e, q_m1);
F_e_m2 = diff(U_e, q_m2);
F_e_m3 = diff(U_e, q_m3);
F_e_m4 = diff(U_e, q_m4);
F_e_m = [F_e_m1; 
         F_e_m2; 
         F_e_m3; 
         F_e_m4];

% Elastic forces acting on ring finger
disp("Computing elastic forces acting on ring finger...")
F_e_r1 = diff(U_e, q_r1);
F_e_r2 = diff(U_e, q_r2);
F_e_r3 = diff(U_e, q_r3);
F_e_r4 = diff(U_e, q_r4);
F_e_r = [F_e_r1; 
         F_e_r2; 
         F_e_r3; 
         F_e_r4];

% Elastic forces acting on little finger
disp("Computing elastic forces acting on little finger...")
F_e_l1 = diff(U_e, q_l1);
F_e_l2 = diff(U_e, q_l2);
F_e_l3 = diff(U_e, q_l3);
F_e_l4 = diff(U_e, q_l4);
F_e_l = [F_e_l1; 
         F_e_l2; 
         F_e_l3; 
         F_e_l4];

% Vector of elastic forces
F_e = [F_e_w; 
       F_e_t; 
       F_e_i; 
       F_e_m; 
       F_e_r; 
       F_e_l];
F_e = simplify(F_e);

% Time necessary to compute elastic forces
T_E = toc;
disp(['Elastic forces computed in ', num2str(T_E), ' seconds.'])

%-------------------------------------------------------------------------------
% COUPLING BETWEEN PIP AND DIP JOINTS
%-------------------------------------------------------------------------------

tic;

disp("Applying coupling between PIP and DIP joints of non-thumb fingers...")

% Active joint variables, velocities and accelerations
q_a = [     q_w; 
            q_t; 
       q_i(1:3); 
       q_m(1:3); 
       q_r(1:3); 
       q_l(1:3)];

q_a_dot = [     q_w_dot; 
                q_t_dot; 
           q_i_dot(1:3); 
           q_m_dot(1:3); 
           q_r_dot(1:3); 
           q_l_dot(1:3)];

q_a_ddot = [     q_w_ddot; 
                 q_t_ddot; 
            q_i_ddot(1:3); 
            q_m_ddot(1:3); 
            q_r_ddot(1:3); 
            q_l_ddot(1:3)];

% Multiplier matrix 
G_w = eye(3);
G_t = eye(4);
G_nt = [         eye(3);
        0, 0, r_f3/r_f4];
G = blkdiag(G_w, G_t, G_nt, G_nt, G_nt, G_nt);

% Variables to substitute
q_nt4 = [q_i4, q_m4, q_r4, q_l4];
q_nt4_subs = [(r_f3/r_f4)*q_i3, (r_f3/r_f4)*q_m3, (r_f3/r_f4)*q_r3, (r_f3/r_f4)*q_l3];

q_nt4_dot = [q_i4_dot, q_m4_dot, q_r4_dot, q_l4_dot];
q_nt4_dot_subs = [(r_f3/r_f4)*q_i3_dot, (r_f3/r_f4)*q_m3_dot, (r_f3/r_f4)*q_r3_dot, (r_f3/r_f4)*q_l3_dot]; 

% Substitutions
M = subs(M, q_nt4, q_nt4_subs);

C = subs(C, q_nt4, q_nt4_subs);
C = subs(C, q_nt4_dot, q_nt4_dot_subs);

F_g = subs(F_g, q_nt4, q_nt4_subs);
F_g = simplify(F_g);

F_e = subs(F_e, q_nt4, q_nt4_subs);
F_e = simplify(F_e);

% Time necessary to apply coupling between PIP and DIP joints
T_IP = toc;
disp(['Coupling between PIP and DIP joints of non-thumb fingers applied in ', num2str(T_IP), ' seconds.'])

%-------------------------------------------------------------------------------
% ACTUATION THROUGH ARTIFICIAL TENDONS
%-------------------------------------------------------------------------------

% Coupling parameters of thumb
r_t11 = sym(10)/1000;

r_t21 = r_t11;

r_t31 = sym(10)/1000;
r_t32 = sym(10)/1000;

r_t41 = sym(10)/1000;
r_t42 = sym(10)/1000;
r_t43 = sym(8)/1000;

r_t51 = sym(10)/1000;
r_t52 = sym(10)/1000;
r_t53 = sym(8)/1000;
r_t54 = sym(6)/1000;

r_t61 = r_t51;
r_t62 = r_t52;
r_t63 = r_t53;
r_t64 = r_t54;

% Coupling parameters of non-thumb fingers
r_nt11 = sym(10)/1000;

r_nt21 = r_nt11;

r_nt31 = sym(10)/1000;
r_nt32 = sym(10)/1000;

r_nt41 = sym(10)/1000;
r_nt42 = sym(10)/1000;
r_nt43 = sym(8)/1000;

r_nt51 = r_nt41;
r_nt52 = r_nt42;
r_nt53 = r_nt43;

% Coupling matrix of wrist
P_w = eye(3);

% Coupling matrix of thumb
P_t = [-r_t11,      0,      0,      0;
        r_t21,      0,      0,      0;
            0, -r_t32,      0,      0;
            0,  r_t42, -r_t43,      0;
            0,  r_t52,  r_t53, -r_t54;
            0,  r_t62,  r_t63,  r_t64];

% Coupling matrix of non-thumb fingers
P_nt = [-r_nt11,       0,       0;
         r_nt21,       0,       0;
              0, -r_nt32,       0;
              0,  r_nt42, -r_nt43;
              0,  r_nt52,  r_nt53];

P_i = P_nt;
P_m = P_nt;
P_r = P_nt;
P_l = P_nt;

% Coupling matrix of whole hand
P = blkdiag(P_w, P_t, P_i, P_m, P_r, P_l);

%-------------------------------------------------------------------------------
% CONCLUSION...
%-------------------------------------------------------------------------------

% Total time needed to compute dynamic model
T = T_M + T_C + T_U + T_G + T_E + T_IP;
disp(['Dynamic model computed in (approximately) ', num2str(T), ' seconds.'])