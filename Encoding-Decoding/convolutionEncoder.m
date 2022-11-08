function encodedBits = convolutionEncoder(inputBits)
    currState = "00";

    encodedBits = [];
    for i=1:length(inputBits)
        bit = inputBits(i);
        [currState, out] = trielis(bit, currState);
        encodedBits = [encodedBits out];
%         encodedBits = strjoin(encodedBits, '');
    end
end