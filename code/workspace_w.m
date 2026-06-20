function ps = workspace_w(roms, d_w3)
% Computes workspace of spherical wrist.
% IN - roms: Ranges of Motion (RoMs) of wrist
% IN - d_w3: parameter of wrist
% OUT - ps: points representing workspace

ps = [];

for i = roms(1, :)
  for j = roms(2, :)
    for k = roms(3, :)
      new_point = [-d_w3*sin(i)*cos(j);
                   d_w3*cos(i)*cos(j);
                   d_w3*sin(j)];
      ps = [ps, new_point];
    end
  end
end
end
