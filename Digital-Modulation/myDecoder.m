% This is going to hold the encoder
function decodedBits = myDecoder(bits, encodingScheme, data)
    if strcmp(encodingScheme, "repetition")
        n = length(bits);
        k = n/data;
        decodedBitsRaw = reshape(bits, data, k)';
        for i=1:length(decodedBitsRaw)
            decodedBits(i) = (sum(decodedBitsRaw(i, :))/data)>0.5;
        end
    end
end