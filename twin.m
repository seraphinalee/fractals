function [ s ] = twin( r )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
s = (5 - 22*r - 12*r^2 + sqrt((25 + 260*r + 844*r^2 + 648*r^3 + 144*r^4)))/(12*(2*r + r^2));
end

