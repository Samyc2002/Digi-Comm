%Demonstration of Digital Modulation.
%We first generate random signal (each symbol of 2 bit each here)
%We then added the AWGN with unit mean and compare it with constellation.
%Closer to 1 I have a bit error and count all such errors for all values of SNR. I have taken 10^5 and 10^6 bits of signal in this experiment.

clc;
clear all;
close all;

nF = getConstellationOrBits("nFactor"); %The normalizing factor
constellation = nF*getConstellationOrBits("constellation"); %To store constellation points ie. 1+1j , 1-1j ,  -1-1j , -1+1j in complex double
grey=getConstellationOrBits("grey"); %This is used to map between non - gray and gray constellation points.
numBits = log2(length(constellation));  %This gives the number of bils per symbol.
nSymbols = numBits*100000; %  represents number of symbols used for stimulation. ie 10^5.
Rb = 10;    % Bit rate

EsNo = 0:0.01:5; % multiple Es/N0 values from 0-10 dB 

%Generating nsymbols random 2 bit symbols to use for QPSK
txBits = zeros(1,nSymbols);
for nF = 1:nSymbols %Loop to generate 2 bit random inputs symbols.
 txBits(nF) = randi([0, (2^numBits-1)]); %randomly generates a 2 bit number between 0 and 3 including both of them.
end

encodedBits = myEncoder(txBits, "repetition", Rb);
interleavedBits = myInterleaver(encodedBits, Rb);
[modSymbols, modSymbolsGrey] = myModulator(interleavedBits, constellation, grey);  % Getting Modulated symbols

numEsNo = length(EsNo); %Number of EbN0dB values to check
Perr = zeros(numEsNo,1); %To estimate error for each EbN0dB value and add it to estimate
PerrGrey = zeros(numEsNo,1); %To estimate error for each EbN0dB value and add it to estimate for Gray code

for nF = 1:numEsNo %EbN0dB for loop
    currEsNo = EsNo(nF); %The current value of EbN0dB being tested for BER.
    esno = 10^(currEsNo/10); %We convert EbN0dB from dB to decimal unit.
    sigma = sqrt(1/(2*esno)); %The corresponding varience for noise.
    
    % add 2d Gaussian noise to our symbols.
    rxModSymbols = modSymbols +sigma*randn(Rb*nSymbols,1)+1i*sigma*randn(Rb*nSymbols,1); %For adding WNGN
    
    [detModSymbols, detModSymbolsGrey] = myDemodulator(rxModSymbols, constellation, grey);
    deInterleavedBits = myDeinterleaver(detModSymbols, Rb);
    decodedModSymbols = myDecoder(deInterleavedBits, "repetition", Rb);
    
    %To calculate bit errors here, for faster execution.
    numErrs=zeros(nSymbols,1);
    for s=1:nSymbols
        bitError=0;   %To count error per bit    
        for t = 1:numBits
            if decodedModSymbols(t) ~= txBits(t)
                bitError = bitError+1;  %adding error for each incorrectly decieded bit.
            end
            numErrs(s) = bitError; %To store the total bit error for each word 
        end
    end
    error = numErrs;
    
    numGreyErrs = zeros(nSymbols,1);
    %For gray encoded
    for s = 1:nSymbols
        d_gray = de2bi(detModSymbolsGrey(s),numBits); %To get a zero padded 2 bit binary string for ease of comparing.
        iBin = de2bi(modSymbolsGrey(s),numBits);  %To get a zero padded 2 bit binary string for ease of comparing.
        bitError = 0;   %To count error per bit
        for t = 1:numBits
            if d_gray ~= iBin(t)
                bitError = bitError+1;  %adding error for each incorrectly decieded bit.
            end
            numGreyErrs(s) = bitError; %To store the total bit error for each word 
        end
    end
    errorsGray = numGreyErrs; 
    
    %BER calculations for that snr.
    Perr(nF) = Perr(nF)+ sum(error)/(nSymbols); %This gives BER per symbol.
    PerrGrey(nF) = PerrGrey(nF)+ sum(errorsGray)/(nSymbols); %This gives BER per symbol. as we are adding error for each of the 4 symbols
end
semilogy(EsNo,PerrGrey); %To plot the BER per nsymbols with EbN0dB.
hold on;
semilogy(EsNo,qfunc((sqrt(10.^(EsNo/10))))); % To plot BER theoretical using Q-function .
legend("Experimental BER with gray code","Theoretical using Q function"); %To all legend
xlabel("EbN0dB (dB)"); %To add EbN0dB label to x axis
ylabel("BER "); %To add BER label to y axis. its BER per symbol.