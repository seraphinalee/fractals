function [ mu0, mu1, r0, r1 ] = params( r )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    r0 = (6*r*(r+2))/(9*r^2+26*r+15);
    r1 = r0/r;
    mu0 = ((2*r)*(r+2)/((2*r+1)*(9*r^2+26*r+15)))/r0;
    mu1 = (1-3*mu0)/6;
end

