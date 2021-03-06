function [  ] = ratioanalysis( eigvals,lowbound,upbound )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
eigvals = repmat(eigvals,length(eigvals),1);
eigvals = eigvals./eigvals';
eigvals = sort(reshape(eigvals,[],1));

mindex1 = 1;
maxdex1 = length(eigvals);

while maxdex1 > mindex1 + 1
    temp = floor((maxdex1+mindex1)/2);
    if eigvals(temp) > lowbound
        maxdex1 = temp;
    else
        mindex1 = temp;
    end
end

mindex2 = 1;
maxdex2 = length(eigvals);

while maxdex2 > mindex2 + 1
    temp = floor((maxdex2+mindex2)/2);
    if eigvals(temp) > upbound
        maxdex2 = temp;
    else
        mindex2 = temp;
    end
end
eigvals = eigvals(mindex1:maxdex2);
f = @(x) countingfunction(eigvals,x);
plotpoints = arrayfun(f,eigvals);
plot(eigvals,plotpoints)






end

