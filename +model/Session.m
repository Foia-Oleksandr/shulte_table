classdef Session < model.SessionInfo

    properties
        taskDurations (1, :) model.TaskDuration 
    end
    
    methods
        function this = Session(id, beginAt, finishAt, complexity, taskDurations)
            this@model.SessionInfo(id, beginAt, finishAt, complexity);
            this.taskDurations = taskDurations;
        end
        
    end
end
