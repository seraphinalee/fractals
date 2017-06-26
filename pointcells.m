function [ cell1 cell2 ] = pointcells( address )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cell1 = primary(address);
cell2 = secondary(address);
cell1 = cell1(2:end);
cell2 = cell2(2:end);
end

