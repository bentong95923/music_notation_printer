function notes_weighting = find_notes_weighting(tempo, note_duration_in_sec, time_threshold)
%NOTE_WEIGHTING Summary of this function goes here
%   Detailed explanation goes here

note_dictionary = [];
i = 1;
while(1)
    time_check = (60/tempo * (2^2)) / (2^(i-1));
    if time_check >= time_threshold
        note_dictionary(i) = time_check;
    else
        break;
    end
    i = i+1;
end

notes_weighting = zeros(1, length(note_duration_in_sec));

for j = 1:length(note_duration_in_sec)
    min_diff = abs(note_duration_in_sec(j) - note_dictionary);
    [~, n_pos] = find(min_diff == min(min_diff));
        %if note_duration_in_sec(j) > note_dictionary(1)
            
    notes_weighting(j) = 2^(n_pos-1);
end

end
