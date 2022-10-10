clc;
clear all;
close all;

% Generator matrix
G = [1 0 0 0 0 1 1;
     0 1 0 0 1 0 1;
     0 0 1 0 1 1 0;
     0 0 0 1 1 1 1];
% Information Bits
info = [0 0 0 0];
% Decoding Strategy
strategy = "std";

% Encoding to n bits
encodedBits = linearEncoder(G, info);
% Spoiling the first bit
encodedBits(1) = 1 - encodedBits(1);
% Decoding with the defined strategy
[H, dmin, stdArr, S, decodedBits] = linearDecoder(G, encodedBits, strategy);

% disp(H);
% disp(dmin);
% disp(S);
disp(decodedBits);