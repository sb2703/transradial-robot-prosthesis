function ps = workspace_nt(roms, pars)
% Computes workspace of given non-thumb finger.
% IN - roms: Ranges of Motion (RoMs) of finger
% IN - pars: anthropometric parameters of finger
% OUT - ps: points representing workspace

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
      new_point = [cos(i).*(pars(1) + pars(2)*c_2 + pars(3)*c_3 + pars(4)*c_4);
                   sin(i).*(pars(1) + pars(2)*c_2 + pars(3)*c_3 + pars(4)*c_4);
                   pars(2)*s_2 + pars(3)*s_3 + pars(4)*s_4];
      ps = [ps, new_point];
    end
  end
end
end