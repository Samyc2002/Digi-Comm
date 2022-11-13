function [codeWord, sourceEncodedBits] = huffmanEncoder(symbols, prob, msg)    
    n = length(prob); 
    codeWord = cell(1, n);
    
    % initializing code word for n = 1 case 
    if n == 1
        codeWord{1} = '1'; 
    end
    x = zeros(n, n); 
    x(:, 1) = (1:n)'; 
    
    % Assigning bit patterns based on probability
    for i = 1:n-1
        % Taking the two minimum probabilities and assigning them the bits
        temp = prob; 
        [~, min1] = min(temp);  
        temp(min1) = 1; 
        [~, min2] = min(temp); 
        prob(min1) = prob(min1) + prob(min2); 
        prob(min2) = 1; 
        x(:, i+1) = x(:, i); 
        % Computing the codewords
        for j = 1:n
            if x(j, i+1) == min1
                codeWord(j) = strcat('0', codeWord(j)); 
            elseif x(j, i+1) == min2
                x(j, i+1) = min1; 
                codeWord(j) = strcat('1', codeWord(j));
            end
        end
    end
    % Reversing the computed codewords to obtain the actual codewords
    codeWord = fliplr(codeWord);

    % Generating the encodedBits based on the codeword mapping generated
    % above.
    sourceEncodedBits = '';
    increment = length(char(symbols(1))); 
    for i = 1:increment:length(msg)
        index = strfind(symbols, msg(i:i+increment-1)); 
        sourceEncodedBits = [sourceEncodedBits char(codeWord(index))];
    end
    
    % converting string sourceEncodedBits to double vector array  
    sourceEncodedBits = double(sourceEncodedBits - double('0')); 
end