function interleavedBits = myInterleaver(rep_Txbits,parts)
    len = length(rep_Txbits);
    interleavedBits =[];
    size = len/parts;
    for i=1:size
        % Repeats the bits
        for j=1:parts
            interleavedBits = [interleavedBits rep_Txbits((j-1)*size + i)];
        end
    end
    interleavedBits = interleavedBits';
    
end