function [uniqueSymbol, probability] = huffmanProcessor(text)
    % Hashmap implementation in matlab
    uniqueSymbol = unique(text); % This stores the unique symbols in the text (keys)
    symbolCount = histc(text, uniqueSymbol); % This stores the count of each symbol in the text (values)
    
    % calculating the probability of each symbol
    probability = symbolCount / length(text); 
    
    % sorting probability in increasing order 
    [probability, index] = sort(probability); 
    uniqueSymbol = uniqueSymbol(index);
end