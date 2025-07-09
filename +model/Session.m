classdef Session

    properties
        id (1,1) uint32 {mustBeInteger}
        beginAt (1,1) datetime
        finishAt (1,1) datetime
        mistakes (1,1) uint32 {mustBeInteger}
        complexity (1,1) uint32 {mustBeInteger}
        taskDurations (2, :) double 
    end
    
    methods
        function this = Session(id, beginAt, finishAt, mistakes, complexity, taskDurations)
            if nargin == 0
                return
            end

            this.id = id;
            this.beginAt = beginAt;
            this.finishAt = finishAt;
            this.mistakes = mistakes;
            this.complexity = complexity;
            this.taskDurations = taskDurations;
        end
        
    end
end
