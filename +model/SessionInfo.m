classdef SessionInfo

    properties
        id (1,1) uint32 {mustBeInteger}
        beginAt (1,1) datetime
        finishAt (1,1) datetime
        mistakes (1,1) uint32 {mustBeInteger}
        complexity (1,1) uint32 {mustBeInteger}
    end

    methods
        function this = SessionInfo(id, beginAt, finishAt, complexity, mistakes)
            if nargin == 0
                return
            end
            this.id = id;
            this.beginAt = beginAt;
            this.finishAt = finishAt;
            this.mistakes = mistakes;
            this.complexity = complexity;
        end
    end
    
end
