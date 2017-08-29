function peaks = onset_peak_picking(x, peak_threshold, time_threshold, fs)
%ONSET_PEAK_PICKING Summary of this function goes here
%   Detailed explanation goes here
peaks = [];
[pks, locs] = findpeaks(x);
for i = 1:length(pks)
    if pks(i) >= peak_threshold
        peaks = [peaks, locs(i)];
    end
end
for j = 1:(length(peaks) - 1)
    
    % Peaks are not too close together
    if (peaks(j+1) - peaks(j)) >= (time_threshold * fs)
        continue;
    % Peaks are too close together
    else
        if (x(peaks(j+1)) > x(peaks(j)))
            peaks(j) = 0;
        else           
            peaks(j+1) = 0;
        end
    end
    
end
peaks(peaks == 0) = [];
end
