%Demonstration of an LTI System

%##############################################
%########  Demonstration of Linearity  ########
%##############################################

%The Input we use here is an impulse function
%The system we use gives an output of y[n] = x[n]+x[n+1]+x[n+2} for n in 1
%to length of x, where x is our input signal

%For example, x[n] = [ 0 0 0 1 0 0 0 ]
%The output should be y[n] = [ 0 1 1 1 0 ]
%As the system is linear, it satisfies homogeniety. Hence, scaling the input by a
%factor will scale the output by the same factor. Again, due to
%linearity, the system will follow superposition. Hence, taking two inputs
%and superposing them will give the same output as we would've got if we
%generated them separately and superposed them.

clc;
clear all;
close all;

size = 7;   % Size of the input vector
mid = floor(size/2)  + 1;
in = input(size, 1);
out = output(in);  %Computing output
scale = 5;  %Scaling Factor
out_scaled = output(scale*in);  %Computing scaled output

linear = 1;

disp("System output is, y[n] = x[n]+x[n+1]+x[n+2]");
disp("-------------------------------------------");
disp("Checking for homogeniety......");
disp("input is......");
disp(in);
disp("Resulting output for the given input......");
disp(out);
disp("Applying a scale of 5......");
disp(out_scaled);
if out_scaled == scale*out
    disp("Which is equal to......");
    disp(out);
    disp("Hence, the system follows homogeniety");
else
    disp("Which is not equal to......");
    disp(out);
    linear = 0;
    disp("Hence, the system does not follow homogeniety");
end

x1 = input(size, 1);
x2 = input(size, 2);
y1 = output(x1);
y2 = output(x2);
a = 2;
b = 3;
out_superposed = output(a*x1 + b*x2);
expr = a*y1+b*y2;

disp("Checking for superposition......");
disp("inputs are......");
disp(x1);
disp("and......");
disp(x2);
disp("Resulting output for the given inputs......");
disp(y1);
disp("and......");
disp(y2);
disp("Superposing x1 and x2 after scaling them by 2 and 3 respectively......");
disp(expr);
if out_superposed == expr
    disp("Which is equal to......");
    disp(out_superposed);
    disp("Hence, the system follows superposition");
else
    disp("Which is not equal to......");
    disp(out_superposed);
    linear = 0;
    disp("Hence, the system does not follow superposition");
end

if linear == 1
    disp("Hence, system is linear");
else
    disp("Hence, system is non-linear");
end

%####################################################
%########  Demonstration of Time Invariance  ########
%####################################################

%Yet again, we take an impulse function and shift it by one second.
%If the system is time invariant, the output of the system should also get
%shifted by one second.

%For example, if x[n] = [ 0 0 0 1 0 0 0 ] with y[n] = [ 0 1 1 1 0 ]
%Then, x[n-1] = [ 0 0 0 0 1 0 0 ] with y[n-1] = [ 0 0 1 1 1 ]

xn1 = input(size, 1);
xn2 = timeShift(xn1);
out1 = output(xn1);
out2 = output(xn2);
out1_shifted = timeShift(out1);
disp("input is......");
disp(xn1);
disp("the corresponding output is......");
disp(out1);
disp("input shifted by 1 sec is......");
disp(xn2);
disp("the corresponding output is......");
disp(out2);
if out1_shifted == out2
    disp("Which is equal to......");
    disp(out1_shifted);
    disp("Hence, the system is time invariant");
else

    disp("Which is not equal to......");
    disp(out1_shifted);
    disp("Hence, the system is not time invariant");
end