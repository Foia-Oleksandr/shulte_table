classdef SessionInfo

    properties
        id (1,1) uint32 {mustBeInteger}
        beginAt (1,1) datetime
        finishAt (1,1) datetime
        size (1,:) char
        orderProperties model.ShulteTableOrder
        view (1,1) model.ShulteTableView
        minDuration (1,1) double
        maxDuration (1,1) double
    end

    methods
        function this = SessionInfo(id, beginAt, finishAt, size, ...
                orderProperties, view, minDuration, maxDuration)
            if nargin == 0
                return
            end
            this.id = id;
            this.beginAt = beginAt;
            this.finishAt = finishAt;
            this.size = size;
            this.orderProperties = sort(orderProperties);
            this.view = view;
            this.minDuration = minDuration;
            this.maxDuration = maxDuration;
        end
    end

end