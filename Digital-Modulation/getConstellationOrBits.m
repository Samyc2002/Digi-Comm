function output = getConstellationOrBits(type)
    switch type
        case "bits"
            output = getBits();
        case "constellation"
            output = getConstellation();
        case "nFactor"
            output = getNFactor();
        otherwise
            output = 0;
    end
end

function constellation = getConstellation()
    constellation = [-1, 1];
end

function parentBits = getBits()
    parentBits = [0, 1];
end

function nFactor = getNFactor()
    nFactor = sqrt(2);
end