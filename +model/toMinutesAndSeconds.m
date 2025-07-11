function [minutes, seconds] = toMinutesAndSeconds(totalSecs)
roundSeconds = round(totalSecs);
minutes = floor(roundSeconds / 60);
seconds = mod(roundSeconds, 60);
end
