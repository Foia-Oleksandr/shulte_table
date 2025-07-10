classdef Session < model.SessionInfo

    properties
        taskDurations (2, :) double 
    end
    
    methods
        function this = Session(id, beginAt, finishAt, complexity, mistakes, taskDurations)
            this@model.SessionInfo(id, beginAt, finishAt, complexity, mistakes);
            this.taskDurations = taskDurations;
        end
        
    end
end
