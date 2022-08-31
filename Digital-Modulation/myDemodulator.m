function [detModSymbols, detBits] = myDemodulator(rxModSymbols, constellation)
    n = length(rxModSymbols);
    argMinI = zeros(n, 1);
    for i=1:n
        [~, argMinI(i)] = min(abs(rxModSymbols(i) - constellation));
    end
    detModSymbols = constellation(argMinI);
    parentBits = getConstellationOrBits("bits");
    detBits = parentBits(argMinI);
end