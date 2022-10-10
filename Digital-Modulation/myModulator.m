function [modSymbols, modSymbolsGrey] = myModulator(input, constellation, gre)
    modSymbols=constellation(input(:)+1); %will have the constellation symbols for non gray
    modSymbolsGrey=gre(input(:)+1);%will get the corresponding gray input for the same constellation input.
    modSymbols=modSymbols.'; %Taking non conjugate transpose of input signal
end