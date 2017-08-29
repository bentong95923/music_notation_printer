
clc
clear
close all

% Reading audio
[s,fs] = audioread('../../../audio/CDEF.wav');
% Select one channel of the stereo audio data
s = (s(:,1))';

THRES_VALUE_MAGNITUE = 7 *(10^-8);
THRES_VALUE_TIME = 0.05;

E0 = get_power_envelope(s);
%figure(110)
%plot(E0)
E0 = thresholding(E0, THRES_VALUE_MAGNITUE);

peaks = onset_peak_picking(E0, THRES_VALUE_MAGNITUE, THRES_VALUE_TIME, fs);
%figure(22)
%plot(E0, '.');