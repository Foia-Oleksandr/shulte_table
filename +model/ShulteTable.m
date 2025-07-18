classdef ShulteTable < handle

    properties (Constant)
        alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', ...
            'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
    end

    properties (SetAccess = immutable)
        size uint32
        numbers uint32
    end

    properties (SetAccess = private)
        selection cell = {}
        nextNumber uint32 = 0
        state (1,1) model.State
        viewProperty (1, 1) model.ShulteTableView
        orderProperties (1, :) model.ShulteTableOrder
    end

    methods (Static)
        function this = template(size)
            this = model.ShulteTable(size, zeros(size, size));
            this.state = model.State.Finished;
        end

        function this = create(size)
            numbers = reshape(randperm(size*size) - 1, size, size);
            this = model.ShulteTable(size, numbers);

            this.state = model.State.Created;
        end
    end
    
    methods (Access = private)
        function this = ShulteTable(size, numbers)
            this.size = size;
            this.numbers = numbers;
        end
    end

    methods

        function setView(this, viewProperty)
            arguments
                this 
                viewProperty model.ShulteTableView
            end
            this.viewProperty = viewProperty;
        end

        function setOrder(this, orderProperties)
            arguments
                this
                orderProperties model.ShulteTableOrder
            end
            this.orderProperties = orderProperties;
        end

        function data = getData(this)
            data = this.numbersToData(this.numbers);
        end

        function [from, to] = getFromToTuple(this)
            values = this.numbersToData([0, this.size^2 - 1]);
            [from, to] = values{:};
        end

        function isExpecedCell = isExpecedCell(this, selection)
            actual = this.numbers(selection{:});
            isExpecedCell = this.nextNumber == actual;
        end

        function this = next(this, selection)
            arguments
                this (1, 1) model.ShulteTable
                selection (2, 1) cell
            end

            if this.state == model.State.Finished
                return
            end

            if this.isExpecedCell(selection)
                this.selection = selection;

                this.nextNumber = this.nextNumber + 1;
                this.state = model.State.InProgress;

                if this.nextNumber > this.size ^ 2 - 1
                    this.state = model.State.Finished;
                end
            end
        end

        function selection = currentCell(this)
            selection = [this.selection{:}];
        end

        function isCompleted = isCompleted(this)
            isCompleted = this.state == model.State.Finished;
        end

    end

    methods (Access = private)

        function data = numbersToData(this, numbers)
            switch(this.viewProperty)
                case model.ShulteTableView.Alphabet
                    data = this.getAlphabetData(numbers);
                case model.ShulteTableView.NumericDecimal
                    data = this.getDecimalData(numbers);
                case model.ShulteTableView.NumericHexedimal
                    data = this.getHexData(numbers);
            end
        end

        function data = getDecimalData(this, numbers)
            if any(this.orderProperties == model.ShulteTableOrder.NumericStartZero)
                shift = 0;
            else
                shift = 1;
            end

            maxNumber = this.size ^ 2 - 1 + shift;
            maxNumberValue = int2str(maxNumber);

            numberLength = strlength(maxNumberValue);

            decimalTemplate = sprintf('%%s%%0%dd', numberLength);

            if any(this.orderProperties == model.ShulteTableOrder.ReverseOrder)
                data = arrayfun(@(x) ...
                    sprintf(decimalTemplate, repmat(char(0160), 1, 2), maxNumber - x), ...
                    numbers, 'UniformOutput', false);
            else
                data = arrayfun(@(x) ...
                    sprintf(decimalTemplate, repmat(char(0160), 1, 2), x + shift), ...
                    numbers, 'UniformOutput', false);
            end
        end

        function data = getAlphabetData(this, numbers)
            maxNumber = this.size ^ 2 - 1;
            symbolsLength = this.digitsForBase(maxNumber, numel(this.alphabet));

            if any(this.orderProperties == model.ShulteTableOrder.ReverseOrder)
                data = arrayfun(@(x) ...
                    this.numberToAlphabet(maxNumber - x, symbolsLength), ...
                    numbers, 'UniformOutput', false);
            else
                data = arrayfun(@(x) ...
                    this.numberToAlphabet(x, symbolsLength), ...
                    numbers, 'UniformOutput', false);
            end
        end

        function symbols = numberToAlphabet(this, x, zeroesBeforeValue)

            codes = this.intToBase(x, numel(this.alphabet));
            symbolCodes = [zeros(1, zeroesBeforeValue - numel(codes)), codes];

            letters = arrayfun( ...
                @(x) (this.alphabet(x + 1)), ...
                symbolCodes, 'UniformOutput', false);

            if any(this.orderProperties == model.ShulteTableOrder.UpperCaseLetters)
                letters = upper([letters{:}]);
            else
                letters = lower([letters{:}]);
            end

            if contains(letters, 'M', 'IgnoreCase',true) ...
                    || contains(letters, 'W', 'IgnoreCase',true) ...
                    || contains(letters, 'B', 'IgnoreCase',true) ...
                    || contains(letters, 'N', 'IgnoreCase',true)
                symbols = sprintf('%s%s%s', repmat(char(0160), 1, 2), letters, repmat(char(32), 1, 1));
            else
                symbols = sprintf('%s%s%s', repmat(char(0160), 1, 2), letters, repmat(char(0160), 1, 1));
            end
        end

        function data = getHexData(this, numbers)
            if any(this.orderProperties == model.ShulteTableOrder.NumericStartZero)
                shift = 0;
            else
                shift = 1;
            end

            maxNumber = this.size ^ 2 - 1 + shift;
            maxNumberValue = dec2hex(maxNumber);

            numberLength = strlength(maxNumberValue);

            if any(this.orderProperties == model.ShulteTableOrder.UpperCaseLetters)
                hexTemplate = sprintf('%%s%%0%dX', numberLength);
            else
                hexTemplate = sprintf('%%s%%0%dx', numberLength);
            end

            if any(this.orderProperties == model.ShulteTableOrder.ReverseOrder)
                data = arrayfun(@(x) ...
                    sprintf(hexTemplate, repmat(char(0160), 1, 2), maxNumber - x), ...
                    numbers, 'UniformOutput', false);
            else
                data = arrayfun(@(x) ...
                    sprintf(hexTemplate, repmat(char(0160), 1, 2), x + shift), ...
                    numbers, 'UniformOutput', false);
            end
        end

    end

    methods (Static, Access = private)
        function out = intToBase(number, base)
            arguments
                number (1, 1) double
                base (1,1) double
            end
            if number == 0
                out = 0;
                return
            end

            value = number;
            digits = model.ShulteTable.digitsForBase(number, base);
            out = zeros(1, digits);
            for k = digits : -1 : 1
                reminder = mod(value, base);
                value = floor(value / base);
                out(k) = reminder;
            end
        end

        function digits = digitsForBase(number, base)
            if number == 0
                digits = 1;
                return
            end

            digits = floor(log(double(number)) / log(base)) + 1;
        end

    end

end
