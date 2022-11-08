function [nextState, output] = trielis(input, currState)
    switch(currState)
        case "00"
            if input == "0"
                output = "00";
                nextState = "00";
            else
                output = "11";
                nextState = "10";
            end
        case "01"
            if input == "0"
                output = "11";
                nextState = "00";
            else
                output = "00";
                nextState = "10";
            end
        case "10"
            if input == "0"
                output = "01";
                nextState = "01";
            else
                output = "10";
                nextState = "11";
            end
        case "11"
            if input == "0"
                output = "10";
                nextState = "01";
            else
                output = "01";
                nextState = "11";
            end
        otherwise
            if input == "0"
                output = "00";
                nextState = "00";
            else
                output = "11";
                nextState = "10";
            end
    end
end