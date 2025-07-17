classdef TargetInfoData
    
    properties
        targetTimes (:, 8) cell
        completionTimes model.CompletionTime
    end
    
    methods
        function this = TargetInfoData(targetTimes, completionTimes)
            this.targetTimes = targetTimes;
            this.completionTimes = completionTimes;
        end
        
        function data = merge(this)
            unmergedSizes = [this.getTargetTableSizes(), this.getCompeltionTableSizes()];
            sizes = unique(unmergedSizes);
            data = cell(numel(unmergedSizes), 8);

            row = 1;

            for k = 1 : numel(sizes)

                target = this.findTargetForSize(sizes(k));
                completions = this.findCompletionForSize(sizes(k));

                standardComletionIndex = arrayfun(@(c) ...
                    c.view == model.ShulteTableView.NumericDecimal && isempty([c.orderProperties]), ...
                    completions);
                standardCompletion = completions(standardComletionIndex);
                customCompletions = completions;
                customCompletions(standardComletionIndex) = [];

                if isempty(target) && isempty(completions)
                    continue;
                end

                tableSize = sprintf('%dx%d', sizes(k), sizes(k));
                
                if ~isempty(target)
                    skillLevel = char(target(4));
                    targetTime = char(target(5));
                elseif ~isempty(standardCompletion)
                    skillLevel = '';
                    targetTime = '';
                end

                if ~isempty(target)  ||  ~isempty(standardCompletion)
                    [symbols, properties, lastResult, avgSearchTime, mistakes] = model.TargetInfoData.getCompletionFields(standardCompletion);
                    data(row, :) = {tableSize, symbols, properties, skillLevel, targetTime, lastResult, avgSearchTime, mistakes};
                    row = row + 1;
                end

                for m = 1 : numel(customCompletions)
                    skillLevel = '';
                    targetTime = '';
                    [symbols, properties, lastResult, avgSearchTime, mistakes] = ...
                        model.TargetInfoData.getCompletionFields(customCompletions(m));

                    data(row, :) = {tableSize, symbols, properties, skillLevel, targetTime, lastResult, avgSearchTime, mistakes};
                    row = row + 1;
                end
            end

            data(row : end, :) = [];
        end

    end

    methods (Access = private)

        function targetSizes = getTargetTableSizes(this)
            targetSizes = model.TargetInfoData.tableSizeToComplexity(this.targetTimes(:, 1));
        end

        function compeltionSizes = getCompeltionTableSizes(this)
            compeltionSizes = model.TargetInfoData.tableSizeToComplexity({this.completionTimes.size});
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

        function completions = findCompletionForSize(this, size)
            tableSize = sprintf('%dx%d', size, size);
            index = find(strcmp({this.completionTimes.size}, tableSize), inf, 'first');

            if isempty(index)
                completions = [];
            else
                completions = this.completionTimes(index);
            end
        end

    end

    methods (Static, Access = private)

        function complexities = tableSizeToComplexity(tableSizes)
            for k = numel(tableSizes) : -1 : 1
                tableSize = sscanf(string(tableSizes(k)), '%dx%d');
                complexities(k) = tableSize(1);
            end
        end

        function [symbols, properties, lastResult, avgSearchTime, mistakes] = getCompletionFields(completion)
            arguments
                completion model.CompletionTime
            end

            if ~isempty(completion)
                if completion.time > 60
                    [minutes, seconds] = model.toMinutesAndSeconds(completion.time);
                    lastResult = sprintf('%.1f (%d min %d sec)', completion.time, minutes, seconds);
                else
                    lastResult = sprintf('%.1f', completion.time);
                end
                symbols = completion.view.briefName;
                properties = model.ShulteTableOrder.orderPropertiesToString(completion.view, completion.orderProperties);
                complexity = model.TargetInfoData.tableSizeToComplexity({completion.size});
                elementsInShulteTable = double(complexity) ^ 2;
                avgSearchTime = sprintf('%.1f', completion.time / elementsInShulteTable);
                mistakes = completion.mistakes;
            else
                symbols = '';
                properties = '';
                lastResult = '';
                avgSearchTime = '';
                mistakes = '';
            end
        end

    end
end

