function [ V,D ] = partialspectra( laplacian,n )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[V,D] = eigs(laplacian,n,'sm');
end

