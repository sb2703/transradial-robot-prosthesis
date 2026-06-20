function ps = workspace_t(roms, a, R)
% Computes workspace of thumb.
% IN - roms: Ranges of Motion (RoMs) of thumb
% IN - pars: anthropometric parameters of thumb
% IN - R: rotation matrix from wrist to thumb base
% OUT - ps: points representing workspace

% Extraction of anthropometric parameters of thumb
a_t1 = a(1);
a_t2 = a(2);
a_t3 = a(3);
a_t4 = a(4);

% Computation of workspace of non-thumb finger
ps = [];
for i = roms(1, :)
  for j = roms(2, :)
    for k = roms(3, :)
      for l = roms(4, :)
        c_2 = cos(j);
        c_3 = cos(j + k);
        c_4 = cos(j + k + l);
        s_2 = sin(j);
        s_3 = sin(j + k);
        s_4 = sin(j + k + l);
        new_point = [cos(i).*(a_t1 + a_t2*c_2 + a_t3*c_3 + a_t4*c_4);
                     sin(i).*(a_t1 + a_t2*c_2 + a_t3*c_3 + a_t4*c_4);
                     a_t2*s_2 + a_t3*s_3 + a_t4*s_4];
        new_point = R*new_point;
        ps = [ps, new_point];
      end
    end
  end
end
end