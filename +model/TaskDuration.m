classdef TaskDuration
    
    properties
        elapsed (1, 1) double
        duration (1, 1) double
        mistakes (1, 1) uint32 {mustBeInteger}
    end
    
    methods
        function this = TaskDuration(elapsed, duration, mistakes)
            if nargin == 0
                return
            end

            this.elapsed = elapsed;
            this.duration = duration;
            this.mistakes = mistakes;
        end
    end
end

