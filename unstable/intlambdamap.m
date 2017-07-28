function [output,unscaled] = lambdamap( lambda,p,m) %the m is the "big" m
%Maps lambda{m} to lambda_{m+1} on the interval
%much simpler, but follows the same structure, as lambdamap.m


%don't have to check for forbidden e.vals here - they never show up.
lambda = lambda/(4/(p*(1-p)))^(m-1);
temp = 4*sqrt(1-p*lambda+p^2*lambda)/sqrt(p^2-2*p^3+p^4);
temp1 = -4/((1-p)*p)-temp;
temp2 = -4/((1-p)*p)+temp;
output = [1/2*(4-sqrt(16+2*(1-p)*p*temp1)) 1/2*(4+sqrt(16+2*(1-p)*p*temp1)) 1/2*(4-sqrt(16+2*(1-p)*p*temp2)) 1/2*(4+sqrt(16+2*(1-p)*p*temp2))];
unscaled = output;
output = output*(4/(p*(1-p)))^m;
end

