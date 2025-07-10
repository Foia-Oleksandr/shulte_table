classdef Options
    
    properties
        complexity uint32 {mustBeInteger, mustBePositive} = 3
        hexNumbers logical = false
        hexLettersUpperCase logical = false
        fontName char = 'Calibri'
        fontSize double = 18
        fontWeight char = 'normal'
        fontAngle char = 'normal'
        fontColor = [0.00,0.00,0.00]
        backgroundFontColor = [1.00,1.00,1.00]
        backgroundColor = [0.94,0.94,0.94]
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

