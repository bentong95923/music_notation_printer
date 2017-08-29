function [pk_diff] = peak_picking2(x)
% Peak picking algorithm

% sig = x;
% % Find the position/index of where the maximum value is in the signal
% p1 = find(sig == max(sig));
% % Remove the maximum value
% sig(p1) = 0;
% % Start from next sample data
% i = p1 + 1;
% % zeros all the value which is above 0 until reaching the next zero crossing
% while sig(i) > 0
%     sig(i) = 0;
%     i = i + 1;
% end

% Find the next max
[~, loc] = findpeaks(x);
pk_diff_array = zeros(1, length(loc)-1);
for i = 1:(length(loc)-1)
    pk_diff_array(i) = loc(i+1) - loc(i);
end

most_diff = mode(pk_diff_array);
pk_diff_array = pk_diff_array(~ismember(pk_diff_array, most_diff));
sec_most_diff = mode(pk_diff_array);

pk_diff = (most_diff + sec_most_diff)/ 2;

end
