function [ac] = std_acf(x, lag)
    %% This function will apply classic autocorrelation to the input signal data
    % and give the result output.
    % Input(s) : x - the input discret signal for autocorrelation
    %            lag - the desired number of lag samples in the output signal
    % Output(s): correlation_output - the resultant signal

    length_x = length(x);
    max_lag = lag;
    current_term_lag = 0;
    ac = zeros(1, max_lag);
    for i = 1:max_lag    
        % Sum of terms for each i
        sumTerms = 0;
        % for each element in y   
        for j = 1:length_x - max_lag
            if j+i-1 > length_x
                current_term_lag = 0;
            else
                current_term_lag = x(j+i-1);
            end
            sumTerms = sumTerms + x(j) * current_term_lag;
            ac(i) = sumTerms;
        end
    end
    % Normalization
    ac = ac/max(ac);
end