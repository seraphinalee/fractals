function [  ] = ratioanalysis( eigvals,lowbound,upbound,segs)
%Function that takes in a row vector of eigenvalues and plots ratios



%The premise here is to compute the nxn matrix of ratios and then linearize
%it, before eliminating for unique and plotting

%The unique bit is to make plotting faster - plotting lines on top of each
%other is slower than filtering them out and getting ie 10^-4 resolution
%(good enough for us)

eigvals = repmat(eigvals,length(eigvals),1);
eigvals = eigvals./eigvals';
eigvals = sort(reshape(eigvals,[],1));
eigvals = eigvals';

mindex1 = 1;
maxdex1 = length(eigvals);

%quick little binary search to get the lower bound

while maxdex1 > mindex1 + 1
    temp = floor((maxdex1+mindex1)/2);
    if eigvals(temp) > lowbound
        maxdex1 = temp;
    else
        mindex1 = temp;
    end
end

%and binary search again to get the upper bound
%these binary searches may(?) be off by 1 but it's not a big problem, just
%visualization

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
eigvals = eigvals(mindex1:mindex2);
%filter for unique ratios...
eigvals = uniquetol(eigvals,(upbound-lowbound)/segs);


%plot what's left
plot([0;1],[eigvals',eigvals'])





end

