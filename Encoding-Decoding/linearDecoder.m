function [H, dmin, stdArr, S, decodedBits] = linearDecoder(G, rxBits, strategy)

    % Dimentions of the generator matrix
    sz = size(G);
    rows = sz(1);
    cols= sz(2);

    % Generating parity matrix
    H = gen2par(G);
    dmin = min(sum(G, 2));

    % Generating coedwords
    kCodewords = 0:(2^rows)-1;
    nCodewords = zeros(2^rows, cols);
    for i=1:length(kCodewords)
        d = dec2bin(kCodewords(i), rows)-'0';
        d = d*G;
        for j=1:length(d)
            d(j) = rem(d(j), 2);
        end
        for j=1:length(d)
            nCodewords(i, j) = d(j);
        end
    end
    
    % Generating standard array
    standardArray = zeros(2^(cols-rows), 2^rows, cols);
    for k=1:cols+1
        for i=1:2^rows
            for j=1:cols
                standardArray(k, i, j) = nCodewords(i, j);
            end
        end
    end
    for i=2:cols+1
        for j=1:2^rows
            standardArray(i, j, i-1) = 1 - standardArray(i, j, i-1);
        end
    end
    for i=cols+2:2^(cols-rows)
        for j=1:2^rows
            codeword = [];
            for m=1:cols
                codeword = [codeword standardArray(1, j, m)];
            end
            found = 0;
            disp("initial");
            disp(bin2dec(int2str(codeword)));
            for m=1:cols
                if found==1
                    break;
                end
                for n=1:cols
                    if found==1
                        break;
                    end
                    if m==n
                        continue;
                    else
                        if found==1
                            break;
                        end
                        codeword(m) = 1 - codeword(m);
                        codeword(n) = 1 - codeword(n);
                        for a=1:i-1
                            if found==1
                                break;
                            end
                            for b=1:2^rows
                                if found==1
                                    break;
                                end
                                matches = 0;
                                for c=1:cols
                                    if codeword(c) == standardArray(a, b, c)
                                        matches = matches+1;
                                    end
                                end
                                if matches==cols
                                    continue;
                                else
                                    for x=1:cols
                                        standardArray(i, j, x) = codeword(x);
                                    end
                                    disp("final");
                                    disp(bin2dec(int2str(codeword)));
                                    found = 1;
                                end
                            end
                        end
                        a=i;
                        if found==1
                            break;
                        end
                        for b=1:j-1
                            if found==1
                                break;
                            end
                            matches = 0;
                            for c=1:cols
                                if codeword(c) == standardArray(a, b, c)
                                    matches = matches+1;
                                end
                            end
                            if matches==cols
                                continue;
                            else
                                for x=1:cols
                                    standardArray(i, j, x) = codeword(x);
                                end
                                disp("final");
                                disp(bin2dec(int2str(codeword)));
                                found = 1;
                            end
                        end
                    end
                end
            end
        end
    end


    % Formatting standard array
    for i=1:2^(cols-rows)
        for j=1:2^rows
            stdArr(i, j) = strjoin(string(standardArray(i, j, :)), "");
        end
    end

    % Generating syndrome table
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

    % Decoding using ML
    if strcmp(strategy, "ml")
        for i=1:2^rows
            dist(i) = sum(xor(rxBits, nCodewords(i)));
        end
        [~, ind] = min(dist);
        decodedBits = nCodewords(ind,:);
    end

    % Decoding using Standard Array
    if strcmp(strategy, "std")
        for i=1:cols+1
            for j=1:2^rows
                matches = 0;
                for k=1:cols
                    if rxBits(k)==standardArray(i, j, k)
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
