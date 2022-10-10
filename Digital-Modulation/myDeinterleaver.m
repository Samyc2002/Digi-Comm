function deInterleavedBits = myDeinterleaver(bits,parts)
    deInterleavedBits = [];
    size = length(bits)/parts;
    for i=1:parts
        % Repeats the bits
        for j=1:size
            deInterleavedBits = [deInterleavedBits bits((j-1)*parts + i)];
        end
    end
end