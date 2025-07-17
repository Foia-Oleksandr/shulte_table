classdef ShulteTableOrder
    enumeration
        NumericStartZero
        UpperCaseLetters
        ReverseOrder
    end

    methods (Static)
        function properties = charToProperties(value)

            propertyItems = jsondecode(value);
            if isempty(propertyItems{1})
                properties = model.ShulteTableOrder.empty;
            else
                properties = cellfun(@(x) model.ShulteTableOrder.(x),  propertyItems);
            end
        end

        function value = orderPropertiesToString(view, properties)
            arguments
                view (1,1) model.ShulteTableView
                properties (1,:) model.ShulteTableOrder
            end

            firstElement = {'1', '0'};
            direction = {'Fwd', 'Bkwd'};
            charCase = {'lwr', 'upr'};

            parts = {};
            switch view
                case model.ShulteTableView.Alphabet
                    parts(end + 1) = direction(any(properties == model.ShulteTableOrder.ReverseOrder) + 1);
                    parts(end + 1) = charCase(any(properties == model.ShulteTableOrder.UpperCaseLetters) + 1);
                case model.ShulteTableView.NumericDecimal
                    parts(end + 1) = firstElement(any(properties == model.ShulteTableOrder.NumericStartZero) + 1);
                    parts(end + 1) = direction(any(properties == model.ShulteTableOrder.ReverseOrder) + 1);
                case model.ShulteTableView.NumericHexedimal
                    parts(end + 1) = firstElement(any(properties == model.ShulteTableOrder.NumericStartZero) + 1);
                    parts(end + 1) = direction(any(properties == model.ShulteTableOrder.ReverseOrder) + 1);
                    parts(end + 1) = charCase(any(properties == model.ShulteTableOrder.UpperCaseLetters) + 1);
            end

            value = char(join(parts, '|'));
        end
    end
end
