function [ mindex ] = countingfunction( eigvals,x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
mindex = 1;
maxdex = length(eigvals);
if x > eigvals(end)
    mindex = maxdex;
    return
end
if x < eigvals(1)
    mindex = 0;
    return
end
while maxdex > mindex + 1
    temp = floor((maxdex+mindex)/2);
    if eigvals(temp) > x
        maxdex = temp
    else
        mindex = temp
    end
end

end

