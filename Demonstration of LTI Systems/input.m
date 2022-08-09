function input = input(size, type)
    if type == 1    %Default input for all the functions
        input = in1(size);
    else
        if type == 2    %input for superposition
            input = in2(size);
        end
    end
end

function input = in1(size)
    input = zeros(size, 1);  %Taking a vector of zeros
    mid = floor(size/2)  + 1;
    input(mid) = 1;  %Using an impulse function
end

function input = in2(size)
    input = zeros(size, 1);  %Taking a vector of zeros
    t = 1:size;
    mid = floor(size/2) + 1;
    input(t>=mid) = 1;  %Using an unit stepfunction
end
