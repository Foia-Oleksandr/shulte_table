classdef Session

    properties
        id (1,1) uint32 {mustBeInteger}
        beginAt (1,1) datetime
        finishAt (1,1) datetime
        complexity (1,1) uint32 {mustBeInteger}
        orderProperties model.ShulteTableOrder = model.ShulteTableOrder.empty
        view (1,1) model.ShulteTableView = model.ShulteTableView.NumericDecimal
    end

    methods
        function this = Session(id, beginAt, finishAt, complexity, orderProperties, view)
            if nargin == 0
                return
            end
            this.id = id;
            this.beginAt = beginAt;
            this.finishAt = finishAt;
            this.complexity = complexity;
            this.orderProperties = sort(orderProperties);
            this.view = view;
        end
    end
    
end
