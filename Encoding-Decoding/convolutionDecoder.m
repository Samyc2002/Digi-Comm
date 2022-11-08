function decodedBits = convolutionDecoder(inputBits)
    len = length(inputBits);
    matrix = zeros(1+len, 4, 2);
    for i=1:1+len
        for j=1:4
            for k=1:2
                matrix(i, j, k) = -1;
            end
        end
    end

    matrix(1,1,2) = 0;
    for i=1:len
        for j=1:4
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

    decodedBits =  "0" ;
    curr = 1;
    for i=len:-1:2
        decodedBits = [decodedBits assignBit(matrix(i,curr,1))];
        curr = matrix(i,curr,1);
    end

    decodedBits = strjoin(decodedBits, '');
    decodedBits = flip(decodedBits);
end

function hammingDistance = getHammingDistance(bits1, bits2)
    hammingDistance = abs(bin2dec(bits1) - bin2dec(bits2));
end

function bit = assignBit(num)
    if num<3
        bit = "0";
    else
        bit = "1";
    end
end