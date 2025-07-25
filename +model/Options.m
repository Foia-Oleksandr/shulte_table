classdef Options
    
    properties
        complexity uint32 {mustBeInteger, mustBePositive} = 3
        shulteTableView model.ShulteTableView = model.ShulteTableView.NumericDecimal;
        zeroStartIndexing logical = false
        reverseOrder logical = false
        hexNumbers logical = false
        lettersUpperCase logical = false
        fontName char = 'Calibri'
        fontSize double = 18
        fontWeight char = 'normal'
        fontAngle char = 'normal'
        fontColor (1, 3) double = [0.00,0.00,0.00]
        backgroundFontColor (1, 3) double = [1.00,1.00,1.00]
        backgroundColor (1, 3) double = [0.94,0.94,0.94]
        tableRowStriping logical = false
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

