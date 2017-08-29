%function [correlation_output] = autocorrelation(x, lag, fs)
%% This function will apply classic autocorrelation to the input signal data
% and give the result output.
% Input(s) : x - the input discret signal for autocorrelation
%            lag - the desired number of lag samples in the output signal
%            fs - the sampling frequency of input signal x
% Output(s): correlation_output - the resultant signal

clear
clc
close all

[y0, fs] = audioread('../../../audio/C single.wav');
b = transpose(y0(:,1)); % changing signal y0 from column vector to row vector
max_lag = 800; %how many lags you want to analyse
lag_b = b;
covar = zeros(1,max_lag+1); %array of covariances 
corr = zeros(1, max_lag); %array of correlations
mean_b = mean(b);
mean_lag_b = mean_b;
length_b = length(b);
% for each lag
for i = 1:(1+max_lag)
    % for each element in b    
    for j = 1:length_b
        if i-1 ~= 0 && j == 1 % the 
            %lag_b = [b(i:length(b)), zeros(1,i-1)];
            lag_b = b(i:length_b);
            mean_lag_b = mean(lag_b);
            % Adding zeros at the back
            %lag_b = [lag_b zeros(1,i-1)];
        end
        if (j+i-1) > length_b
            y = 0;
        else
            y = b(j+i-1);
        end
        covar(i) = covar(i) + (b(j) - mean_b) * (y - mean_lag_b);
    end
    % Sample covarience
    covar(i) = 1/(length_b-1) * covar(i);
    corr(i) = covar(i)/(std(b) * std(lag_b));
end
plot(corr);
%end
