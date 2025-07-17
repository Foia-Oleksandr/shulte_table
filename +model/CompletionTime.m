classdef CompletionTime
   
    properties
        size char
        view model.ShulteTableView
        orderProperties  model.ShulteTableOrder
        time double
        date datetime
        mistakes uint32
    end
    
    methods
        function this = CompletionTime(size, view, orderProperties, time, date, mistakes)
            if nargin == 0
                return
            end
            this.size = size;
            this.view = view;
            this.orderProperties = orderProperties;
            this.time = time;
            this.date = date;
            this.mistakes = mistakes;
        end
    end
end

