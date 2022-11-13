% This function implements the viterbi algorithm. It creates a graph of
% nodes which are connected via the states. Each node has the previous
% state and a weight. Once the graph is built, we traverse it backwards and
% track all the states to get the decoded message.
function decodedBits = convolutionDecoder(inputBits)
    len = length(inputBits);
    % Making a (n+1)x4x2 matrix to store the states and weights. Each
    % matrix(i,j) contains a 1x2 vector where matrix(i,j,1) is the state
    % and matrix(i,j,2) is the weight
    matrix = zeros(1+len, 4, 2);
    % Initialising everything with -1 (default value - Also useful while
    % checking if the node is visited)
    matrix(:,:,:) = -1;

    % Starting the algorithm by making the start point at 00 state with 0
    % weight.
    matrix(1,1,2) = 0;
    for i=1:len
        for j=1:4
            % Iterating through each state and if it is visited, operate
            % over it.
            % Each operation involves finding the next possible states, the
            % weight and assigning it either if it is not visited or it is
            % visited, but the calculated weight is smaller than the
            % already existing one
            if matrix(i,j,2)>=0
                [states, outs] = trelisMap(dec2bin(j-1));
                currWeight = matrix(i,j,2);
                for k=1:2
                    if matrix(i+1,bin2dec(states(k))+1,2) == -1
                        matrix(i+1,bin2dec(states(k))+1,1) = j;
                        matrix(i+1,bin2dec(states(k))+1,2) = currWeight+getHammingDistance(outs(k), inputBits(i));
                    else
                        if matrix(i+1,bin2dec(states(k))+1,2) > currWeight+getHammingDistance(dec2bin(bin2dec(outs(k))), outs(k))
                            matrix(i+1,bin2dec(states(k))+1,1) = j;
                            matrix(i+1,bin2dec(states(k))+1,2) = currWeight+getHammingDistance(dec2bin(bin2dec(outs(k))), outs(k));
                        end
                    end
                end
            end
        end
    end

    % Compiling the decoded bits in a string
    decodedBits =  "0" ;
    curr = 1;
    % traversing the graph backwards to track all the states and get the
    % decoded message.
    for i=len:-1:2
        decodedBits = [decodedBits assignBit(matrix(i,curr,1))];
        curr = matrix(i,curr,1);
    end

    decodedBits = strjoin(decodedBits, '');
    decodedBits = flip(decodedBits);
end

% Computes the hamming distance between two blocks of bits.
function hammingDistance = getHammingDistance(bits1, bits2)
    hammingDistance = abs(bin2dec(bits1) - bin2dec(bits2));
end

% Assigns 0 or 1 based on the input number.
function bit = assignBit(num)
    if num<3
        bit = "0";
    else
        bit = "1";
    end
end