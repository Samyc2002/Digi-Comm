% This is going to hold the encoder
function encodedBits = myEncoder(bits, encodingScheme, data)
    if strcmp(encodingScheme, "repetition")
        k = length(bits(1));
        n = data*k;
        G = ones(n, k);
        encodedBitsRaw = bits.*G;
        encodedBits = reshape(encodedBitsRaw, 1, []);
    end
end