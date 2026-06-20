function [ps_dip, ps] = workspace_dip(roms, a)
% Computes workspace of given non-thumb finger, with reference to
% both the fingertip and the distal interphalangeal (DIP) joint.
% IN - roms: Ranges of Motion (RoMs) of non-thumb finger
% IN - a: anthropometric parameters of non-thumb finger
% OUT - ps_dip: points representing workspace of DIP joint
% OUT - ps: points representing workspace of fingertip

% Extraction of anthropometric parameters of non-thumb finger
a_nt1 = a(1);
a_nt2 = a(2);
a_nt3 = a(3);
a_nt4 = a(4);

% Computation of workspaces 
ps_dip = [];
ps = [];

for i = roms(1, :)
  for j = roms(2, :)
    for k = roms(3, :)
      c_2 = cos(j);
      c_3 = cos(j + k);
      s_2 = sin(j);
      s_3 = sin(j + k);
      new_point_dip = [cos(i).*(a_nt1 + a_nt2*c_2 + a_nt3*c_3);
                       sin(i).*(a_nt1 + a_nt2*c_2 + a_nt3*c_3);
                                         a_nt2*s_2 + a_nt3*s_3];
      ps_dip = [ps_dip, new_point_dip];

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