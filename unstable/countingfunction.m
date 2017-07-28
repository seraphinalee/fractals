function [ mindex ] = countingfunction( eigvals,x )
%reports number of elemets of eigvals <= x
%binary searches to x, returns the index AKA how many elements less than x



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
        maxdex = temp;
    else
        mindex = temp;
    end
end

end

