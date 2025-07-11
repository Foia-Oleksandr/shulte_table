classdef TargetInfoData
    
    properties
        targetTimes (:, 6) cell
        completionTimes model.CompletionTime
    end
    
    methods
        function this = TargetInfoData(targetTimes, completionTimes)
            this.targetTimes = targetTimes;
            this.completionTimes = completionTimes;
        end
        

        function data = merge(this)
            
            sizes = unique([this.getTargetTableSizes, this.getCompeltionTableSizes]);
            data = cell(numel(sizes), 6);

            for k = 1 : numel(sizes)

                target = this.findTargetForSize(sizes(k));
                completion = this.findCompletionForSize(sizes(k));

                if isempty(target) && isempty(completion)
                    continue;
                end

                tableSize = sprintf('%dx%d', sizes(k), sizes(k));
                
                if ~isempty(target)
                    skillLevel = char(target(2));
                    targetTime = char(target(3));
                else
                    skillLevel = '';
                    targetTime = '';
                end

                if ~isempty(completion)
                    if completion.time > 60
                        [minutes, seconds] = model.toMinutesAndSeconds(completion.time);
                        lastResult = sprintf('%.1f (%d min %d sec)', completion.time, minutes, seconds);
                    else
                        lastResult = sprintf('%.1f', completion.time);
                    end
                    avgSearchTime = sprintf('%.1f', completion.time / double(completion.size) ^ 2);
                    mistakes = completion.mistakes;
                else
                    lastResult = '';
                    avgSearchTime = '';
                    mistakes = '';
                end
 
                data(k, :) = {tableSize, skillLevel, targetTime, lastResult, avgSearchTime, mistakes};
            end
        end

    end

    methods (Access = private)

        function targetSizes = getTargetTableSizes(this)
            tableSizes = this.targetTimes(:, 1);
            for k = numel(tableSizes) : -1 : 1
                talbeSize = sscanf(string(tableSizes(k)), '%dx%d');
                targetSizes(k) = talbeSize(1);
            end
        end

        function compeltionSizes = getCompeltionTableSizes(this)
            compeltionSizes = [this.completionTimes.size];
        end

        function target = findTargetForSize(this, size)
            tableSize = sprintf('%dx%d', size, size);
            index = find(strcmp(this.targetTimes(:, 1), tableSize), 1, 'first');
            if isempty(index)
                target = [];
            else
                target = this.targetTimes(index, :);
            end
        end

        function completion =findCompletionForSize(this, size)
            index = find([this.completionTimes.size] == size, 1, 'first');
            if isempty(index)
                completion = [];
            else
                completion = this.completionTimes(index);
            end
        end

    end
end

