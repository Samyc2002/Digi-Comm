function encodedBits = convolutionEncoder(inputBits)
    % Starting with a state of 00
    currState = "00";

    encodedBits = [];
    % Encoding the bits
    for i=1:length(inputBits)
        bit = inputBits(i);
        [currState, out] = trielis(bit, currState);
        encodedBits = [encodedBits out];
%         encodedBits = strjoin(encodedBits, '');
    end
end