function [ cell1 cell2 ] = pointcells( address )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cell1 = [address(1); address(3:end)];
cell2 = [address(2); address(3:end)];
end

