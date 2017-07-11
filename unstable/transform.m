function [ altfunc ] = transform(xcors,eigenfunc,index)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
altfunc = 2*sin(index*pi*xcors)'-eigenfunc;
end

