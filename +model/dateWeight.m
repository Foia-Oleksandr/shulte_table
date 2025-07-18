function weight = dateWeight(date, sortingOrder)
arguments
    date char
    sortingOrder model.SortingOrder
end

dateValue = posixtime(datetime(date));

switch sortingOrder
    case model.SortingOrder.Unordered
        weight = 0;
    case model.SortingOrder.Ascend
        weight = dateValue;
    case model.SortingOrder.Descend
        weight = - dateValue;
end
end
