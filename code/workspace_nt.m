function ps = workspace_nt(roms, a)
% Computes workspace of given non-thumb finger.
% IN - roms: Ranges of Motion (RoMs) of non-thumb finger
% IN - pars: anthropometric parameters of non-thumb finger
% OUT - ps: points representing workspace

% Extraction of anthropometric parameters of non-thumb finger
a_nt1 = a(1);
a_nt2 = a(2);
a_nt3 = a(3);
a_nt4 = a(4);

% Computation of workspace of non-thumb finger
ps = [];
for i = roms(1, :)
  for j = roms(2, :)
    for k = roms(3, :)
      c_2 = cos(j);
      c_3 = cos(j + k);
      c_4 = cos(j + 5*k/3);
      s_2 = sin(j);
      s_3 = sin(j + k);
      s_4 = sin(j + 5*k/3);
      new_point = [cos(i).*(a_nt1 + a_nt2*c_2 + a_nt3*c_3 + a_nt4*c_4);
                   sin(i).*(a_nt1 + a_nt2*c_2 + a_nt3*c_3 + a_nt4*c_4);
                   a_nt2*s_2 + a_nt3*s_3 + a_nt4*s_4];
      ps = [ps, new_point];
    end
  end
end
end