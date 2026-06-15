function [q_h, i] = newton(r, f, J_sym, q_sym, q_0, es)
% Implementation of Newton algorithm to solve inverse kinematics problem.
% IN - r: desired end-effector position
% IN - f: (symbolic) forward kinematics function for end-effector position
% IN - J_sym: (symbolic) Jacobian matrix of manipulator
% IN - q_sym: (symbolic) variables
% IN - q_0: initial configuration
% IN - es: end stops
% OUT - q_h: ''history'' of q evolution towards configuration that achieves r
% OUT - i: number of iterations

% Discretization period
T = 0.1;

% Maximum number of iterations
i_max = 100;

% Minimum q variation to continue
q_minvar = 0.00001;

% Minimum error variation to continue
e_minvar = 0.00001;

% Error system
eigs = -10;
K = eigs*eye(size(r, 1));

% Parameter of objective function
k_0 = 1;

% Algorithm initialization
q_h = q_0;
q = q_0;

i = 0;
dq = realmax;
de = realmax;

e_sym = r - f;

w = simplify(sqrt(det(J_sym*J_sym.')));
q_0_dot_sym = k_0*simplify(gradient(w, q_sym.'));

while((i < i_max) && (dq > q_minvar) && (de > e_minvar))
  
  % Numerical evaluation
  q_0_dot = round(subs(q_0_dot_sym, q_sym.', q.'), 6);
  J = round(subs(J_sym, q_sym.', q.'), 6);
  J_dag = J.'/(J*J.');
  e = round(subs(e_sym, q_sym.', q.'), 6);

  % Update of computed configuration
  q_old = q;
  q = q + T*J_dag*(-K*e) + T*(eye(size(J_sym, 2)) - J_dag*J)*q_0_dot;
  for j = 1:size(q_sym, 1)
    q(j) = max(es(j, 1), min(q(j), es(j, 2)));
  end

  q_h = [q_h, q];
  i = i + 1;

  dq = norm(q - q_old);
  de = norm(e);
end
end
