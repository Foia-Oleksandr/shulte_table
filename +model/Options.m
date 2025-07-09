classdef Options
    
    properties
        complexity uint32 {mustBeInteger, mustBePositive} = 3;
    end

    methods
        function this = loadOptions(this)

            if this.isOptionDefined
                opt = load(model.Config.optionsFile);
                this = opt.this;
            end
        end

        function storeOptions(this)
            save(model.Config.optionsFile, 'this');
        end

    end

    methods (Static)
        function isExist = isOptionDefined()
            isExist = isfile(model.Config.optionsFile);
        end
    end
end

