function output = timeShift(input)
    output = input;
    for i=length(output):-1:2
        output(i) = output(i-1);
    end
end