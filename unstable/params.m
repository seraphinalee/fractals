function [ mu0, mu1, r0, r1 ] = params( r )
%Gives mu0,mu1,r0,r1 as a function of r, assuming problty measure,
%scaling resistance, and constant renormalization constant
    r0 = (6*r*(r+2))/(9*r^2+26*r+15);
    r1 = r0/r;
    mu0 = ((2*r)*(r+2)/((2*r+1)*(9*r^2+26*r+15)))/r0;
    mu1 = (1-3*mu0)/6;
end

