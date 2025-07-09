classdef ShulteTable < handle    
    properties (SetAccess = immutable)
        size uint32
        numbers uint32
    end

    properties (SetAccess = private)
        nextNumber uint32 = 1;
        state (1,1) model.State
    end
    
    methods
        function this = ShulteTable(size, repeatNumber)
            if nargin == 0
                size = 5;
            elseif nargin == 2
                this.numbers = ones(size, size) * repeatNumber;
                this.state = model.State.Finished;
            else
                this.numbers = reshape(randperm(size*size), size, size);
                this.state = model.State.Created;
            end
            this.size = size;
        end
        
        function isExpecedCell = isExpecedCell(this, actual)
            isExpecedCell = this.nextNumber == actual;
        end

        function this = next(this)
            if this.state == model.State.Finished
                return
            end

            this.nextNumber = this.nextNumber + 1;
            this.state = model.State.InProgress;

            if this.nextNumber > this.size ^ 2
                this.state = model.State.Finished;
            end
        end

        function isCompleted = isCompleted(this)
            isCompleted = this.state == model.State.Finished;
        end

    end

end
