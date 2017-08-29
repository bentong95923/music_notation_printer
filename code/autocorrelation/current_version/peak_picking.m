function [p1, p2] = peak_picking(x)
% Peak picking algorithm

sig = x;
% Find the position/index of where the maximum value is in the signal
p1 = find(sig == max(sig));
% Remove the maximum value
sig(p1) = 0;
% Start from next sample data
i = p1 + 1;
% zeros all the value which is above 0 until reaching the next zero crossing
while sig(i) > 0
    sig(i) = 0;
    i = i + 1;
end

% Find the next max
p2 = find(sig == max(sig));
if length(p2) ~= 1
    error('The ACF has only one peak.');
end

