function in = input(size)
    in = zeros(size, 1);  %Taking a vector of zeros
    mid = floor(size/2)  + 1;
    in(mid) = 1;  %Using an impulse function
end
