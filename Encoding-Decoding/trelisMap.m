function [nextStates, outputs] = trelisMap(currState)
    switch(currState)
        case "00"
            outputs = ["00" "11"];
            nextStates = ["00" "10"];
        case "01"
            outputs = ["11" "00"];
            nextStates = ["00" "10"];
        case "10"
            outputs = ["01" "10"];
            nextStates = ["01" "11"];
        case "11"
            outputs = ["10" "01"];
            nextStates = ["01" "11"];
        otherwise
            outputs = ["00" "11"];
            nextStates = ["00" "10"];
    end
end