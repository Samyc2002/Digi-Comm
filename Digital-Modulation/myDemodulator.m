function [ detModSymbols, detSymbolsGrey ] = myDemodulator (rxModSymbols, constellation, grey)
    nSymbols = length(rxModSymbols);
    detModSymbols=zeros(nSymbols,1); %We initialize decisions with zeros corresponding to all n symbols for fast execution.
    for n=1:nSymbols         
        distances = abs(rxModSymbols(n)-constellation);%Absolute distance from each constellation point.
        [~,detModSymbols(n)] = min(distances); %The minimum of those is choosen for that recieved point.
    
    end
    detSymbolsGrey=grey(detModSymbols);%Maps back non gray to gray
    detModSymbols=detModSymbols-1;%To get it between 0 and 3.
end