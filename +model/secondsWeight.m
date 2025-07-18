function weight = secondsWeight(seconds, sortingOrder)
arguments
    seconds char
    sortingOrder model.SortingOrder
end

if isempty(seconds)
    secondsValue = Inf;
else
    secondsValue = str2double(seconds);
end

switch sortingOrder
    case model.SortingOrder.Unordered
        weight = 0;
    case model.SortingOrder.Ascend
        weight = secondsValue;
    case model.SortingOrder.Descend
        weight = - secondsValue;
end
end
