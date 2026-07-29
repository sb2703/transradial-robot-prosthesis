function [u] = controller_inv_dyn(M_tm1, C_tm1, F_g_tm1, F_e_tm1, x_tm1, x_d, G, P)
% Computes actuation forces necessary to track a reference signal,
% using a controller based on inverse dynamics control.
% IN - M_tm1: mass matrix at previous timestep
% IN - C_tm1: matrix related to centrifugal and Coriolis forces at previous timestep
% IN - F_g_tm1: gravitational forces at previous timestep
% IN - F_e_tm1: elastic force at previous timestep
% IN - x_tm1: state of system at previous timestep
% IN - x_d: reference to track
% IN - G: multiplier matrix for coupling of PIP and DIP joints
% IN - P: coupling matrix due to actuation through (artificial) tendons
% OUT - u: actuation forces

% Extraction of variables and parameters
n = size(x_tm1, 1)/2;
x_1_tm1 = x_tm1(1:n);
x_2_tm1 = x_tm1(n+1:end);

% Gain matrices
omega_n = 18;
zeta = 0.99;
K_P = (omega_n^2)*eye(n);
K_D = (2*omega_n*zeta)*eye(n);

% Control action through feedback linearization
y = K_P*(x_d - x_1_tm1) - K_D*x_2_tm1;

u_a = G.'*(M_tm1*G*y + C_tm1*G*x_2_tm1 + F_g_tm1 + F_e_tm1);
u = (G/(G.'*G))*u_a;
u = vpa(u);

% Tension of tendons
P_dag = (P.'*P)\P.';
N = null(P.');

lambda = 10;

f = P_dag.'*u_a + lambda*sum(N, 2);
f = vpa(f);
disp("Tension of tendons (must be positive):")
disp(f)
end