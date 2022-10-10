function [H, dmin, stdArr, S, decodedBits] = linearDecoder(G, rxBits, strategy)

%     Dimentions of the generator matrix
    sz = size(G);
    rows = sz(1);
    cols= sz(2);

%     Generating parity matrix
%     P = zeros(rows, cols-rows, 'uint8');
%     for i=1:rows
%         for j=rows+1:cols
%             P(i, j-rows) = G(i, j);
%         end
%     end
% 
%     I = zeros(cols-rows, cols-rows, 'uint8');
%     for i=1:cols-rows
%         for j=1:cols-rows
%             if i==j
%                 I(i, j) = 1;
%             end
%         end
%     end

    H = gen2par(G);
    dmin = min(sum(G, 2));

%     Generating coedwords
    kCodewords = 0:(2^rows)-1;
    nCodewords = zeros(2^rows, cols);
    for i=1:length(kCodewords)
        d = dec2bin(kCodewords(i), cols)-'0';
        for j=1:length(d)
            nCodewords(i, j) = d(j);
        end
    end
    
%     Generating standard array
    stdArr = zeros(cols+1, 2^rows, cols);
     for i=1:2^rows
        for j=1:cols
            stdArr(1, i, j) = nCodewords(i, j);
        end
    end
    for i=2:cols+1
        for j=1:2^rows
            stdArr(i, j, i-1) = 1 - stdArr(i, j, i-1);
        end
    end

%     Generating syndrome table
    errors = zeros(cols+1, cols);
    for i=2:cols+1
        errors(i, i-1) = 1 - errors(i, i-1);
    end
    S = H*errors';
    S = S';
    for i=1:cols+1
        for j=1:cols-rows
            S(i, j) = rem(S(i, j), 2);
        end
    end

%     Decoding using ML
    if strcmp(strategy, "ml")
        for i=1:2^rows
            dist(i) = sum(xor(rxBits, nCodewords(i)));
        end
        [~, ind] = min(dist);
        decodedBits = nCodewords(ind,:);
    end

%     Decoding using Standard Array
    if strcmp(strategy, "std")
        for i=1:cols+1
            for j=1:2^rows
                matches = 0;
                for k=1:cols
                    if rxBits(k)==stdArr(i, j, k)
                        matches = matches + 1;
                    end
                end
                if matches==cols
                    decodedBits = nCodewords(j,:);
                    break;
                end
            end
        end
    end

%     Decoding using Syndrome Table
    if strcmp(strategy, "syn")
        syn = H*rxBits';
        for i=1:cols+1
            matches = 0;
            for j=1:cols-rows
                if syn(j)==S(i, j)
                    matches = matches+1;
                end
            end
            if matches==cols-rows
                ind = i;
                break;
            end
        end
        err = errors(ind,:);
        decodedBits = xor(err, rxBits);
    end
end