function out = system(size)
    out = zeros(size, 1);
    mid = floor(size/2) + 1;
    out(mid-2) = 1;
    out(mid-1) = 1;
    out(mid) = 1;
    out(mid+1) = 1;
    out(mid+2) = 1;
end