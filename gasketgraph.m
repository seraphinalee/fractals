function [ output ] = gasketgraph( gasketdata )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
f0 = @(x) 1/2(x-[0.5,tan(60)*0.5]) + [0.5,tan(60)*0.5];
f1 = @(x) 1/2(x-[1,0]) + [1,0];
f2 = @(x) 1/2(x-[0,1]) + [0,1];


end

