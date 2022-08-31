function y = output(x)
    n = length(x)-2;
    y = zeros(1, n);
    for i = 1:n
        y(i) = (x(i) + x(i+1) + x(i+2));
    end
    %y(floor(n/2)+1) = 10;
end
