close all
clear
clc
% % Time specifications:
%    Fs = 50000;                    % samples per second
%    dt = 1/Fs;                   % seconds per sample
%    StopTime = 1.5;                % seconds
%    t = (0:dt:StopTime-dt)';     % seconds
% % Sine wave:
%    Fc = 2000;                      % frequency of signal (hertz)
%    x = sin(2*pi*Fc*t);          % signal
%    N = x + 2*randn(size(t));    % noise
%    %Plot the signal versus time:
%    figure(1);
%    plot(t,x);
%    figure(2);
%    plot(t,N);
%    xlabel('time (in seconds)');
%    title('Signal versus Time');
%    %zoom xon;                   % zooming fseature enabled
   
  
   
   
   
%% Audio Read

    % Define stop time (Rectanglar window) in sec
    DEF_TIME_STOP = 0.3;
    % Zero padding set
    SET_ZERO_PADDING = false;
    % Load Audio
    [yo,Fs] = audioread('../../audio/C8.wav');
    
    % Sample period
    dt = 1/Fs;
    % Signal time length in sec
    signalTime = length(yo)*dt;
    % Select one channel of steoro signal
    yo = yo(:,1);
    % Number of samples selected according to stop time
    numSampleSelected = floor(length(yo) / signalTime * DEF_TIME_STOP);
    % Define time intervals
    if SET_ZERO_PADDING == true
        % Set time interval for whole signal length
        time = 0:dt:(signalTime)-dt;
        % Select the signal according to the stop time definied
        y = yo(1:numSampleSelected);
        % Zero pad to match the original length of signal
        y = [y;zeros(length(yo)-numSampleSelected,1)];
    else
        % Set time interval for whole signal length
        time = 0:dt:(signalTime)-dt;        
        % Set time interval according to the length of selected range of the
        % signal
        time = time(1:numSampleSelected);  
        % Select the signal according to the stop time definied
        y = yo(1:numSampleSelected);
    end
    figure(4)
    plot(time,y); xlabel('Seconds'); ylabel('Amplitude');
    
%% FFT
   % FFT size set in power
   SET_FFT_SIZE_POW_2 = 14;
   % FFT size
   nfft = 2^SET_FFT_SIZE_POW_2; 
   % Take fft, padding with zeros so that length(X) is equal to nfft
   X = fft(y,nfft);
   % FFT is symmetric, throw away second half
   X = X(1:nfft/2);
   % Take the magnitude of fft of x
   mx = abs(X);
   % Frequency vector
   Fc = (0:nfft/2-1)*Fs/nfft;
   % Generate the plot, title and labels.
   figure(3);
   plot(time,y);
   title('Sine Wave Signal');
   xlabel('Time (s)');
   ylabel('Amplitude')
   plot(Fc,mx);
   title('Power Spectrum of the audio signal');
   xlabel('Frequency (Hz)');
   ylabel('Power');
   % zooming fseature enabled
   zoom xon;
