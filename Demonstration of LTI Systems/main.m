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

size = 10001;   % Size of the input vector
mid = floor(size/2)  + 1;
in = input(size, 1);
out = output(in);  %Computing output
scale = 5;  %Scaling Factor
out_scaled = output(scale*in);  %Computing scaled output

linear = 1;

t_in = 1:size;  %Input Time Frame
t_out = 1:size-2;  %Output Time Frame
disp("System output is, y[n] = x[n]+x[n+1]+x[n+2]");
figure(1)
tiledlayout(5,2)

ax1 = nexttile;
plot(ax1, t_in, in)
title(ax1,"Checking for homogeniety......")
ylabel(ax1, "Input Plot")

ax2 = nexttile;
plot(ax2, t_out, out)
title(ax2,"Resulting output for the given input......")
ylabel(ax2, "Output Plot")

ax3 = nexttile;
plot(ax3, t_out, out_scaled)
title(ax3, "Applying a scale of 5......")
ylabel(ax3, "Three times Output Plot")

if out_scaled == scale*out
    ax4 = nexttile;
    plot(ax4, t_out, out_scaled)
    title(ax4, "Which is equal to......")
    ylabel(ax4, "Three times Output Plot")
else
    ax4 = nexttile;
    plot(ax4, t_out, out_scaled)
    title(ax4, "Which is not equal to......")
    ylabel(ax4, "Three times Output Plot")
end

x1 = input(size, 1);
x2 = input(size, 2);
y1 = output(x1);
y2 = output(x2);
a = 2;
b = 3;
out_superposed = output(a*x1 + b*x2);
expr = a*y1+b*y2;

t1 = 1:size;
t2 = 1:size;
t_out1 = 1:size-2;
t_out2 = 1:size-2;

ax5 = nexttile;
plot(ax5, t1, x1)
title(ax5, "Checking for superposition......")
ylabel(ax5, "Input 1")

ax6 = nexttile;
plot(ax6, t2, x2)
title(ax6, "Checking for superposition......")
ylabel(ax6, "Input 2")

ax7 = nexttile;
plot(ax7, t_out1, y1)
title(ax7, "Resulting output for the first input")
ylabel(ax7, "Output 1")

ax8 = nexttile;
plot(ax8, t_out2, y2)
title(ax8, "Resulting output for the first input")
ylabel(ax8, "Output 2")

ax9 = nexttile;
plot(ax9, t_out2, expr)
title(ax9, "Superposing x1 and x2 after scaling them by 2 and 3 respectively......")
ylabel(ax9, "Expected Output")

if out_superposed == expr
    ax10 = nexttile;
    plot(ax10, t_out2, out_superposed)
    title(ax10, "Which is equal to......")
    ylabel(ax10, "Superposed Signal")
else
    ax10 = nexttile;
    plot(ax10, t_out2, out_superposed)
    title(ax10, "Which is not equal to......")
    ylabel(ax10, "Superposed Signal")
    linear = 0;
end

if linear == 1
    disp("The system is linear");
else
    disp("The system is non-linear");
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

timeInvariant = 1;

tn1 = 1:size;  %Input Time Frame
tn2 = timeShift(tn1);  %Shifted Input Time Frame
tOut1 = 1:size-2;  %Output 1 Time Frame
tOut2 = 1:size-2;  %Output 2 Time Frame
tOut_shifted = 2:size-1;  %Shifted Output Time Frame

figure(2)
tiledlayout(5, 1)

bx1 = nexttile;
plot(bx1, tn1, xn1)
title(bx1, "Input Signal")
ylabel(bx1, "Input Signal")

bx2 = nexttile;
plot(bx2, tOut2, out1)
title(bx2, "the corresponding output signal is......")
ylabel(bx2, "Output Signal")

bx3 = nexttile;
plot(bx3, tn2, xn2)
title(bx3, "input shifted by 1 sec is......")
ylabel(bx3, "Time Shifted Input Signal")

bx4 = nexttile;
plot(bx4, tOut2, out2)
title(bx4, "the corresponding output is......")
ylabel(bx4, "Output of Time Shifted Input Signal")

if out1_shifted == out2
    bx5 = nexttile;
    plot(bx5, tOut_shifted, out1_shifted)
    title(bx5, "Which is equal to......")
    ylabel(bx5, "Time Shifted Output")
    disp("The system is time invariant");
else
    timeInvariant = 0;
    bx5 = nexttile;
    plot(bx5, tOut_shifted, out1_shifted)
    title(bx5, "Which is not equal to......")
    ylabel(bx5, "Time Shifted Output")
    disp("The system is not time invariant");
end

if linear*timeInvariant==0
    disp("Hence, the system is not LTI")
else
    disp("Hence, the system is LTI")
end