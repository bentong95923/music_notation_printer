clear
clc
close all

% c is the signal to be analysed
c = [5 4 3 2 1 0 1 2 3 4 5 4 3 2 1 0 1 2 3 4 5 4 3 2 1 0 1 2 3 4 5 4 3 2 1 0 1 2 3 4 5];
% Orginal length of c
length_c = length(c);
% Doubling the signal size with zeores in order to correlate the whole signal
c = [c zeros(1,length(c))];
% Initialize output of the acf
acf = zeros(1, length_c);
% lag in time
lag = 0;
% Initialize y
y = zeros(1, length_c);
% Run for each term in acf
for j = 1:length_c
    % Sum of x(j) * x(j+r)
    for i = 1:length_c
         y(i) = c(i)*c(i+lag);
         acf(j) = sum(y);
    end
    % increment lag by 1
    lag = lag+1;
end
figure(1)
% plot signal c
plot(c)
figure(2)
% plot the acf of c
plot(acf,'*')
