% Demonstration of Convolution

    % The Input we use here is an impulse function %
    The system we use here is a rectangular signal

    % For example,
    x[n] = [0 0 0 1 0 0 0] % The system is h[n] =
               [0 0 1 1 1 0 0 0] % The convolution should give y[n] =
                   [0 0 0 1 1 1 0 0 0 0 0 0 0]

    clc;
clear all;
close all;

size = 101;
x = input(size);
% Input h = system(size);
% System y = convolution(x, h);

t = 1 : size;
% Input Time Frame tOut = 1 : length(y);
% Output Time Frame

        figure(1) tiledlayout(4, 1)

            ax1 = nexttile;
plot(ax1, t, x) title(ax1, "Input Signal") ylabel(ax1, "Input Signal")

    ax2 = nexttile;
plot(ax2, t, h) title(ax2, "System") ylabel(ax2, "System")

    ax3 = nexttile;
plot(ax3, tOut, y) title(ax3, "Output Signal of Convolution")
    ylabel(ax3, "Convoluted Signal")

        yExp = conv(x, h);
ax4 = nexttile;
plot(ax4, tOut, yExp) title(ax4, "Expected Convolution Output")
            ylabel(ax4, "Expected Signal")

        % Demonstration of Cross
    - Correlation using Convolution

          % In convolution we flip the signal,
    shift it and move % In correlation we conj the signal shift it and move
        % so the difference is one flips it and the other conjugates it
        % In order to perform Correlation through convolution %
        1. Flip the signal by yourself %
        2. Take conjugate of signal by yourself

        p = xcorr(x, h);
q = convolution(x, fliplr(conj(h)));

figure(2) tiledlayout(2, 1)

    tp = 1 : length(p);
bx1 = nexttile;
plot(bx1, tp, p) title(bx1, "Correlation from inbuilt function")
    ylabel(bx1, "Expected Correlation")

        tq = 1 : length(q);
bx2 = nexttile;
plot(bx2, tq, q) title(bx2, "Correlation from custom function")
    ylabel(bx2, "Calculated Correlation")
