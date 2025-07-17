classdef ShulteTableView
    enumeration
        NumericDecimal('Dec')
        NumericHexedimal('Hex')
        Alphabet('Alph')
    end

    properties
        briefName (1, :) char
    end

    methods

        function this = ShulteTableView(briefName)
            this.briefName = briefName;
        end

    end
end
