clc;
clear all;
close all;

% Generator matrix for linear encoding/decoding
G = [1 0 1 0 1; 
     0 1 0 1 1];

% Information Bits
info = [0 0 1 0 0 0];

% Encoding to n bits
% Using Linear Encoder
% encodedBits = linearEncoder(G, info);
% Using Convolutional Encoder
encodedBits = convolutionEncoder(string(info));

% Spoiling three bit
% encodedBits(1) = 1 - encodedBits(1);
% encodedBits(3) = 1 - encodedBits(3);
% encodedBits(4) = 1 - encodedBits(4);

% Decoding Strategy
% strategy = "ml";

% Decoding with the defined strategy (linear decoder)
% [H, dmin, stdArr, S, decodedBits] = linearDecoder(G, encodedBits, strategy);

% Decoding (convolution decoder)
% disp(encodedBits);
decodedBits = convolutionDecoder(encodedBits);

% Display the output

% For linear encoder/decoder
% disp(H);
% disp(dmin);
% disp(length(unique(stdArr)));
% disp(bin2dec(stdArr));
% disp(S);
% disp(decodedBits);

% For convolutional encoder/decoder
disp(decodedBits);