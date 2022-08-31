clc;
clear all;
close all;

numBits = 10^4;
txBits = randi([0, 1], 1, numBits);

constellation = getConstellationOrBits("constellation");
modSymbols = myModulator(txBits, constellation);

snr = 0:0.01:10;
numSNR = length(snr);
Perr = zeros(numSNR, 1);
PerrActual = zeros(numSNR, 1);

for i=1:numSNR
    currSNR = snr(i);
    EbNo = 10^(currSNR/10);
    sigma = sqrt(1/(EbNo));
    rxModSymbols = modSymbols + sigma * randn(numBits, 1) + 1i * sigma * randn(numBits, 1);
    [detModSymbols, detBits] = myDemodulator(rxModSymbols, constellation);
    err = (detBits ~= txBits);
    Perr(i) = sum(err)/numBits;
    PerrActual(i) = sqrt(EbNo);
end

semilogy(snr,Perr); %To plot the BER per nsymbols with SNR.
hold on; %To add both data in the same plot
semilogy(snr,qfunc(PerrActual)); % To plot BER theoretical using Q-function .
legend("Experimental BER ","Theoretical using Q function"); %To all legend
xlabel("SNR (dB)"); %To add SNR label to x axis
ylabel("BER (Bit Error Rate)"); %To add BER label to y axis. its BER per symbol.