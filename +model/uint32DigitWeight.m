function weight = uint32DigitWeight(value, sortingOrder)
arguments
    value
    sortingOrder model.SortingOrder
end
if strcmp(value, 'current')
    valueWeight = inf;
else
    valueWeight = double(value);
end

if isnan(valueWeight) && model.Config.isDebug
    disp('uint32DigitWeight convert value to NaN. value:')
    disp(value);
end

switch sortingOrder
    case model.SortingOrder.Unordered
        weight = 0;
    case model.SortingOrder.Ascend
        weight = valueWeight;
    case model.SortingOrder.Descend
        weight = -valueWeight;
end
end

