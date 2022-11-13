% Clear the console and remove all the variables from workspace
clc;
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Linear Encoding / Decoding %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Information Bits
info = [0 0 0 0];
% Generator matrix for linear encoding/decoding
G = [1 0 0 0 0 1 1;
     0 1 0 0 1 0 1;
     0 0 1 0 1 1 0;
     0 0 0 1 1 1 1];
% Channel Encoding using the generator matrix
encodedBits = linearEncoder(G, info);
% Decoding Strategy
strategy = "std";
% Decoding with the defined strategy
[H, dmin, stdArr, S, decodedBits] = linearDecoder(G, encodedBits, strategy);
% Displaying the output
disp("Encoded Bits");
disp(encodedBits);
disp("Parity Matrix");
disp(H);
disp("Dmin");
disp(dmin);
disp("standard Array");
disp(bin2dec(stdArr));
disp(length(unique(stdArr)));
disp("Syndrome Table");
disp(S);
disp("Decoded Bits");
disp(decodedBits);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convolution Encoding / Decoding %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Information Bits
info = [0 0 1 0 0 0];
% Channel Encoding using Convolutional Encoder
encodedBits = convolutionEncoder(string(info));
% Spoiling three bits
% encodedBits(1) = 1 - encodedBits(1);
% encodedBits(3) = 1 - encodedBits(3);
% encodedBits(4) = 1 - encodedBits(4);
% Decoding using Convolution Decoder (Viterbi Algorithm)
decodedBits = convolutionDecoder(encodedBits);
% Displaying the output
disp("Encoded Bits");
disp(encodedBits);
disp("Decoded Bits");
disp(decodedBits);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Source Encoding / Decoding %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Message
message = 'The discovery of the structure by Crick and Watson, with all its biological implications, has been one of the major scientific events of this century.';
% Source Probability (finding the symbols and the corresponding 
% probability)
[uniqueSymbols, probability] = huffmanProcessor(message);
% Source Encoding using Huffman Encoder
[codeWord, sourceEncodedBits] = huffmanEncoder(uniqueSymbols, probability, message);
% Source Decoding using Huffman Decoder
decodedBits = huffmanDecoder(uniqueSymbols, codeWord, sourceEncodedBits);
% Displaying the output
disp("Message")
disp(message)
disp("Encoded Message")
disp(sourceEncodedBits)
disp("Decoded Message")
disp(decodedBits)
if message == decodedBits
    disp("Decoded Successfully")
else
    disp("Decoded with errors")
end
