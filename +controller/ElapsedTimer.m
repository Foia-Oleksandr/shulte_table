classdef ElapsedTimer < handle
    
    properties (Access = private)
        startTime (1,1) uint64
        elapsedTime (1,1) double
        isRunning (1,1) logical = false
    end
    
    methods

        function obj = start(obj)
            if ~obj.isRunning
                obj.startTime = tic;
                obj.isRunning = true;
            end
        end

        function obj = pause(obj)
            if obj.isRunning
                obj.elapsedTime = obj.elapsedTime + toc(obj.startTime);
                obj.isRunning = false;
            end
        end

        function seconds = getElapsed(obj)
            if obj.isRunning
                seconds = obj.elapsedTime + toc(obj.startTime);
            else
                seconds = obj.elapsedTime;
            end
        end

        function obj = reset(obj)
            obj.elapsedTime = 0;
            obj.isRunning = false;
        end
    end
end
