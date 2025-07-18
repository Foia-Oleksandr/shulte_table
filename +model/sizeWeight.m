function weight = sizeWeight(tableSize,sortingOrder)
arguments
    tableSize char
    sortingOrder model.SortingOrder
end

dimensions = sscanf(string(tableSize), '%dx%d');
complexity = dimensions(1);

switch sortingOrder
    case model.SortingOrder.Unordered
        weight = 0;
    case model.SortingOrder.Ascend
        weight = complexity;
    case model.SortingOrder.Descend
        weight = - complexity;
end
end
