clc;
clear all;
close all;

size = 7;
x = input(size);
h = system(size);
disp(x);
disp(h);

y = convolution(x, h, size);
disp(y);