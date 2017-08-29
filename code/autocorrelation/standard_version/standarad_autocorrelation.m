clc
clear
close all
% Read audio
[y, fs] = audioread('../../../audio/C4 note.wav');
y = (y(:,1))';
% Length of input signal
length_y = length(y);
% Max lag definied
max_lag = 1700;
current_term_lag = 0;
% Initialize ac output
ac = zeros(1, max_lag);
for i = 1:max_lag    
    % Sum of terms for each i
    sumTerms = 0;
    % for each element in y   
    for j = 1:length_y - max_lag
        % Tapering - if lag term is out of range will be 0
        if j+i-1 > length_y
            current_term_lag = 0;
        else
            % Else equal to the value of the function with the time lag
            current_term_lag = y(j+i-1);
        end
        % Sum
        sumTerms = sumTerms + y(j) * current_term_lag;
        ac(i) = sumTerms;
    end
end
plot(ac);