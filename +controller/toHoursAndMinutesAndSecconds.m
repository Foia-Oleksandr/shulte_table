function [hours, minutes, seconds] = toHoursAndMinutesAndSecconds(totalSecs)
roundSeconds = round(totalSecs);
[totalMinutes, seconds] = controller.toMinutesAndSecconds(roundSeconds);
[hours, minutes] = controller.toMinutesAndSecconds(totalMinutes);
end
