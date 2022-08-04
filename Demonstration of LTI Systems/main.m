%Demonstration of an LTI System

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

size = 5;   % Size of the input vector
input = zeros(size, 1);  %Taking a vector of zeros
mid = floor(size/2)  + 1;
input(mid) = 1;  %Using an impulse function
out = output(input);  %Computing output
scale = 5;  %Scaling Factor
out_scaled = output(scale*input);  %Computing scaled output

ok = 1;

disp("Checking for homogeniety......");
disp("input is......");
1*input
disp("Resulting output for the given input......");
1*out
disp("Applying a scale of 5......");
1*out_scaled
if out_scaled == scale*out
    disp("Which is equal to......");
    5*out
else
    disp("Which is not equal to......");
    5*out
    ok = 0;
end

x1 = input;
input(mid) = 0;
input(mid+2) = 1;
x2 = input;
y1 = output(x1);
y2 = output(x2);
a = 2;
b = 3;
out_superposed = output(a*x1 + b*x2);
expr = a*y1+b*y2;

disp("Checking for superposition......");
disp("inputs are......");
1*x1
disp("and......");
1*x2
disp("Resulting output for the given inputs......");
1*y1
disp("and......");
1*y2
disp("Superposing x1 and x2 after scaling them by 2 and 3 respectively......");
1*expr
if out_superposed == expr
    disp("Which is equal to......");
    out_superposed
else
    disp("Which is not equal to......");
    out_superposed
    ok = 0;
end

if ok == 1
    disp("Hence, system is linear");
else
    disp("Hence, system is non-linear");
end

