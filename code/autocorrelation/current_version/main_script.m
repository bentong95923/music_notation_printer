clc
clear
close all

fig_no = 1;

fprintf('Programme is running, please be patient...\n')

% Load Audio
[y0,fs] = audioread('../../../audio/c scale fast.wav');

% Sample period
dt = 1/fs;

% Tempo of the piece (in quarter note)
TEMPO = 120;

% Number of lags defined
NUM_LAGS = 1700;

% Theshold value
THRES_VALUE_ACF = 0.15;
THRES_VALUE_ONSET = 7 *(10^-8);
% The time in sec that people can play
THRES_VALUE_TIME = 0.05;

% Select one channel of steoro signal
y0 = (y0(:,1))';

%% Onset detection
power_envelope = get_power_envelope(y0);
power_envelope = thresholding(power_envelope, THRES_VALUE_ONSET);
peaks = onset_peak_picking(power_envelope, THRES_VALUE_ONSET, THRES_VALUE_TIME, fs);

%% Duration detection
duration_notes = duration_detection(peaks, length(y0));
notes_weighting = find_notes_weighting(TEMPO, duration_notes/fs, 0.05);

% Initialize the result
piano_note = cell(1,length(peaks));

%% Pitch detection of individual note 
for p = 1:length(peaks)
    sampleStart = peaks(p)+ 1;
    if p == length(peaks)
        sampleEnd = length(y0);
    else
        sampleEnd = peaks(p+1);
    end
    % Select the signal according to the stop time definied
    y = y0(sampleStart:sampleEnd);

    % Applying window
    window_funct = 1;
    figure(p)
    % Autocorrelation
    ac = std_acf(window_funct.*y, NUM_LAGS);
    % Thresholding
    filtered_ac = thresholding(ac, THRES_VALUE_ACF);
    % Peak picking
    [p1, p2] = peak_picking(filtered_ac);
    % Finding the frequency of the input signal
    freq = fs /abs(p1 - p2);
    piano_note{p} = find_piano_note(freq);
    if (p == 1)
        fprintf('Piano note detected:\n');
    end
    % Display results from ACF
    fprintf('%s, at %.2f Hz\n', piano_note{p}, freq);
    % Plot results
    subplot(2,2,1)
    plot(window_funct.*y);
    title('signal with window applied');
    subplot(2,2,2)
    plot(y);
    title('Input Audio Signal Data');
    subplot(2,2,3)
    plot(ac);
    title('Result of ACF')
    subplot(2,2,4)
    plot(filtered_ac);
    title('Result of filtered ACF');
end

% Display results for Onset and notes weighting
figure(p+1)
plot(power_envelope)
title('Onset Peaks')

fprintf('Notes detected in sequence:\n');
disp(piano_note);

fprintf('Notes weighting:\n')
disp(notes_weighting)

fprintf('Program terminated.\n')

