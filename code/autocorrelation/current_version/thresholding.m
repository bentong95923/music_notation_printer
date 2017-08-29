function [x_out] = thresholding(y, threshold)
%FILTER_ZC Summary of this function goes here
%   Detailed explanation goes here

length_y = length(y);
x_out = zeros(1, length_y);

% % The first sample is always the maximum
% max_zc_index = 1;
% 
% % max_zc_index = floor(length_y/2);
% % 
% % if mod(length_y, 2) == 0
% %     max_zc_index = length_y/2 + 1;
% % end
% 
% while (y(max_zc_index) > threshold) || (y(max_zc_index) <= 0)
%     max_zc_index = max_zc_index +1;
% end
% 
% max_zc = y(max_zc_index);
% str = sprintf('Threshold taken: %.2f\n', max_zc);
% disp(str)
for i = 1:length_y
    if y(i) > threshold
        x_out(i) = y(i);
    end
end

end

