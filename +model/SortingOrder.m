classdef SortingOrder

    enumeration
        Unordered('⇅')
        Ascend('▲')
        Descend('▼')
    end

    properties
        sortingSymbol
    end
    
    methods
        
        function this = SortingOrder(sortingSymbol)
            this.sortingSymbol = sortingSymbol;
        end

        function item = next(this)
            items = enumeration('model.SortingOrder');
            index = find(items == this, 1, 'first');
            nextIndex = mod(index, numel(items)) + 1;
            item = items(nextIndex);
        end

    end

    methods (Static)
    
        function item = symbolToSortingOrder(sortingSymbol)
            items = enumeration('model.SortingOrder');
            for e = 1:numel(items)
                if strcmp(items(e).sortingSymbol, sortingSymbol)
                    item = items(e);
                    return
                end
            end
            item = model.SortingOrder.Unordered;
        end

    end
end
