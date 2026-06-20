function [ps_mf, ps] = workspace_mf(roms, a)
% Computes workspace of given non-thumb finger, with reference to
% both the fingertip and the (midpoint of) middle phalanx.
% IN - roms: Ranges of Motion (RoMs) of non-thumb finger
% IN - a: anthropometric parameters of non-thumb finger
% OUT - ps_mf: points representing workspace of (midpoint of) middle phalanx
% OUT - ps: points representing workspace of fingertip

% Extraction of anthropometric parameters of non-thumb finger
a_nt1 = a(1);
a_nt2 = a(2);
a_nt3 = a(3);
a_nt4 = a(4);

% Computation of workspaces
ps_mf = [];
ps = [];

for i = roms(1, :)
  for j = roms(2, :)
    for k = roms(3, :)
      c_2 = cos(j);
      c_3 = cos(j + k);
      s_2 = sin(j);
      s_3 = sin(j + k);
      new_point_mf = [cos(i).*(a_nt1 + a_nt2*c_2 + (a_nt3/2)*c_3);
                      sin(i).*(a_nt1 + a_nt2*c_2 + (a_nt3/2)*c_3);
                                        a_nt2*s_2 + (a_nt3/2)*s_3];
      ps_mf = [ps_mf, new_point_mf];

      c_4 = cos(j + 5*k/3);
      s_4 = sin(j + 5*k/3);
      new_point = [cos(i).*(a_nt1 + a_nt2*c_2 + a_nt3*c_3 + a_nt4*c_4);
                   sin(i).*(a_nt1 + a_nt2*c_2 + a_nt3*c_3 + a_nt4*c_4);
                                     a_nt2*s_2 + a_nt3*s_3 + a_nt4*s_4];
      ps = [ps, new_point];
    end
  end
end
end