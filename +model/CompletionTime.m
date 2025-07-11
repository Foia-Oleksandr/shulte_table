classdef CompletionTime
   
    properties
        size uint32
        time double
        date datetime
        mistakes uint32
    end
    
    methods
        function this = CompletionTime(size, time, date, mistakes)
            if nargin == 0
                return
            end
            this.size = size;
            this.time = time;
            this.date = date;
            this.mistakes = mistakes;
        end
    end
end

