function output = getConstellationOrBits(type)
    switch type
        case "bits"
            output = getBits();
        case "constellation"
            output = getConstellation();
        case "grey"
            output = getGrey();
        case "nFactor"
            output = getNFactor();
        otherwise
            output = 0;
    end
end

function constellation = getConstellation()
    constellation = [1+1i -1+1i -1-1i 1-1i];
end

function parentBits = getBits()
    parentBits = ["00", "01", "10", "11"];
end

function grey = getGrey()
    grey=[0 1 3 2];
end

function nFactor = getNFactor()
    nFactor = double(1.0)/double(sqrt(2));  %The normalizing factor
end