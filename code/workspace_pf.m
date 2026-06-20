function [ps_pf, ps] = workspace_pf(roms, a)
% Computes workspace of given non-thumb finger, with reference to
% both the fingertip and the (midpoint of) proximal phalanx.
% IN - roms: Ranges of Motion (RoMs) of non-thumb finger
% IN - a: anthropometric parameters of non-thumb finger
% OUT - ps_pf: points representing workspace of (midpoint of) proximal phalanx
% OUT - ps: points representing workspace of fingertip

% Extraction of anthropometric parameters of non-thumb finger
a_nt1 = a(1);
a_nt2 = a(2);
a_nt3 = a(3);
a_nt4 = a(4);

% Computation of workspaces
ps_pf = [];
ps = [];

for i = roms(1, :)
  for j = roms(2, :)
    c_2 = cos(j);
    s_2 = sin(j);
    new_point_pf = [cos(i).*(a_nt1 + (a_nt2/2)*c_2);
                    sin(i).*(a_nt1 + (a_nt2/2)*c_2);
                                      (a_nt2/2)*s_2];
    ps_pf = [ps_pf, new_point_pf];

    k = 0;
    c_3 = cos(j + k);
    c_4 = cos(j + 5*k/3);
    s_3 = sin(j + k);
    s_4 = sin(j + 5*k/3);
    new_point = [cos(i).*(a_nt1 + a_nt2*c_2 + a_nt3*c_3 + a_nt4*c_4);
                 sin(i).*(a_nt1 + a_nt2*c_2 + a_nt3*c_3 + a_nt4*c_4);
                                   a_nt2*s_2 + a_nt3*s_3 + a_nt4*s_4];
    ps = [ps, new_point];
  end
end
end