function [ mindex ] = countingfunction( eigvals,x )
%returns how many eigenvalues are less than or equal to x
%eigvals = result from "[eigvals,indices] = sort(real(diag(D)))"
%x must be an eigenvalue
%should probably only be used in counting_graph
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

