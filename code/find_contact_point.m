function [cp, index] = find_contact_point(ps_t, ps_nt)
% Given the workspaces of the thumb and a non-thumb finger,
% finds the best contact point (with reference to thumb fingertip).
% IN - ps_t: workspace of thumb
% IN - ps_nt: workspace of non-thumb finger
% OUT - cp: computed contact point
% OUT - index: index (in workspace of non-thumb finger) relative to cp

% Algorithm initialization
best_dist = realmax;
cp = zeros(3, 1);
index = 0;

% Search of nearest couple of points
for i = 1:size(ps_t, 2)
  for j = 1:size(ps_nt, 2)
    p_t = ps_t(:, i);
    p_nt = ps_nt(:, j);
    dist = norm(p_t - p_nt);
    if (dist < best_dist)
      best_dist = dist;
      cp = p_nt;
      index = j;
    end
  end
end
end