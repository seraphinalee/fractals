function [ neighbors ] = pointneighbors( point )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[cell1,cell2] = pointcells(point);
p = primary(point);
q = secondary(point);
p = p(1);
q = q(1);
neighbors = [primary([mod(p+1,3);cell1]) primary([mod(p+2,3);cell1]) primary([mod(q+1,3);cell2]) primary([mod(q+2,3);cell2]) ];
end

