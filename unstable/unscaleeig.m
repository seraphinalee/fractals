function [ lev1 ] = unscaleeig( scaled, m, r )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[mu0, mu1, r0, r1] = params(r);

lev1 = (scaled)*(r0*mu0)^(m-1);


end

