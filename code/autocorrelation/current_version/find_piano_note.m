function [piano_note] = find_piano_note(detected_freq)

% Initialize the piano frequency table
piano_ft = zeros(1, 88);
% Calculate the frequency for each piano note/key
for n = 1:88
    piano_ft(n) = 440 * (2^((n-49)/12));
end

% Find the difference between the detected frequency and the respected
% piano frequency and store them in an array.
min_freq_diff = abs(detected_freq - piano_ft);
% Find out which index/position number has the minimum difference which
% means the detected frequency is closest to the respected piano key
n_pos = min_freq_diff == min(min_freq_diff);
% List of piano key for matching
piano_note_list = {
    'A0';
    'A0#';
    'B0';
    'C1';
    'C1#';
    'D1';
    'D1#';
    'E1';
    'F1';
    'F1#';
    'G1';
    'G1#';
    'A1';
    'A1#';
    'B1';
    'C2';
    'C2#';
    'D2';
    'D2#';
    'E2';
    'F2';
    'F2#';
    'G2';
    'G2#';
    'A2';
    'A2#';
    'B2';
    'C3';
    'C3#';
    'D3';
    'D3#';
    'E3';
    'F3';
    'F3#';
    'G3';
    'G3#';
    'A3';
    'A3#';
    'B3';
    'C4';
    'C4#';
    'D4';
    'D4#';
    'E4';
    'F4';
    'F4#';
    'G4';
    'G4#';
    'A4';
    'A4#';
    'B4';
    'C5';
    'C5#';
    'D5';
    'D5#';
    'E5';
    'F5';
    'F5#';
    'G5';
    'G5#';
    'A5';
    'A5#';
    'B5'
    'C6';
    'C6#';
    'D6';
    'D6#';
    'E6';
    'F6';
    'F6#';
    'G6';
    'G6#';
    'A6';
    'A6#';
    'B6';
    'C7';
    'C7#';
    'D7';
    'D7#';
    'E7';
    'F7';
    'F7#';
    'G7';
    'G7#';
    'A7';
    'A7#';
    'B7';
    'C8'
};
% Find the respected piano note
piano_note = piano_note_list{n_pos};
end