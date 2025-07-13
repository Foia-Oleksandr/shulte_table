classdef SessionResult < model.Session

    properties
        taskDurations (1, :) model.TaskDuration 
    end
    
    methods
        function this = SessionResult(id, beginAt, finishAt, complexity, taskDurations)
            this@model.Session(id, beginAt, finishAt, complexity);
            this.taskDurations = taskDurations;
        end
        
    end
end
