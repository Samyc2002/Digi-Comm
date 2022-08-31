function out = system(size)
%     out = zeros(size, 1);
%     Start = floor((size-1)/4);
%     End = 3*floor((size-1)/4);
%     for i=Start:End
%         out(i) = 1;
%     end
    t = 1:size;
    out = zeros(size, 1);
    for i=1:10
        out(i) = 1;
    end
end
