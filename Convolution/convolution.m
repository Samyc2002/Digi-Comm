function y = convolution(x, h)
    m = length(x);
    n = length(h);
    X=[x, zeros(m, 1)];
    H=[h, zeros(n, 1)];
    for i=1:m+n-1
        y(i)=0;
        for j=1:n
            if(i-j+1>0)
                y(i)=y(i)+X(j)*H(i-j+1);
            end
        end
    end
end