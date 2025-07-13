classdef Session

    properties
        id (1,1) uint32 {mustBeInteger}
        beginAt (1,1) datetime
        finishAt (1,1) datetime
        complexity (1,1) uint32 {mustBeInteger}
    end

    methods
        function this = Session(id, beginAt, finishAt, complexity)
            if nargin == 0
                return
            end
            this.id = id;
            this.beginAt = beginAt;
            this.finishAt = finishAt;
            this.complexity = complexity;
        end
    end
    
end
