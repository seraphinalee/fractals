function [ s ] = twin( r )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
s = (5-25*r-12*r^2)/(12*r*(2+r))+1/12*sqrt((25+260*r+844*r^2+648*r^3+144*r^4)/(r^2*(2+r)^2));
end

