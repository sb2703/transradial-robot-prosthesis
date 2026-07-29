function [x_out] = dyn_end_stops(x_in, es)
% Auxiliary function to ensure joint variables are within end-stops.
% IN - x_in: state of the system before the application of end-stops
% IN - es: end-stops of joints
% OUT - x_out: state of the system before the application of end-stops

% Initialization
n = size(x_in, 1)/2;
x_out = x_in;

% Effect of end-stops
for i = 1:n
    x_out(i) = max(es(i, 1), min(x_out(i), es(i, 2)));
end
for i = 1:n
    if ((x_out(i) == es(i, 1)) && (x_out(i+n) < 0)) || ((x_out(i) == es(i, 2)) && (x_out(i+n) > 0))
        x_out(i+n) = 0;
    end 
end
end