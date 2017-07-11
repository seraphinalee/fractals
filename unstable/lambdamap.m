function [output] = lambdamap( lambda,p )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
temp = 4*sqrt(1-p*lambda+p^2*lambda)/sqrt(p^2-2*p^3+p^4);
temp1 = -4/((1-p)*p)-temp;
temp2 = -4/((1-p)*p)+temp;
output = [1/2*(4-sqrt(16+2*(1-p)*p*temp1)) 1/2*(4+sqrt(16+2*(1-p)*p*temp1)) 1/2*(4-sqrt(16+2*(1-p)*p*temp2)) 1/2*(4+sqrt(16+2*(1-p)*p*temp2))];
end

