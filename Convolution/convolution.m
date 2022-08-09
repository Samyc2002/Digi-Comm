function y = convolution(x, h, size)
    X=[x, zeros(size, 1)];
    H=[h, zeros(size, 1)];
    y = zeros(2*size-1, 1);
    for i=1:2*size-1
        y(i)=0;
        for j=1:size
            if(i-j+1>0)
                y(i)=y(i)+X(j)*H(i-j+1);
            end
        end
    end
end