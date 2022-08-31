function modSymbols = myModulator(txBits, constellation)
    modSymbols = constellation(bit2int(txBits, log2(length(constellation)))+1);
end