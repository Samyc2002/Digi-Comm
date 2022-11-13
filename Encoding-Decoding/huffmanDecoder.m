function decoded_msg = huffmanDecoder(uniqueSymbols, codeWord, sourceEncodedBits)    
    decoded_msg = []; 
    
    % minimum code word length 
    minI = min(cellfun('length', codeWord));
    
    % bit pointer. This stores the index of the last processed character
    ptr = 1; 
    % Assigning the character based on the bit pattern
    for i = minI:length(sourceEncodedBits)
        if isempty(find(strcmp(codeWord, char(sourceEncodedBits(ptr:i) + '0')), 1)) ~= 1
            ind = find(strcmp(codeWord, char(sourceEncodedBits(ptr:i) + '0')), 1); 
            decoded_msg = [decoded_msg char(uniqueSymbols(ind))]; 
            ptr = i + 1; 
            i = i + minI;
        end
    end
end