function [ mapped ] = map_to_vals_spec( mapping, eigvals )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

mapped = zeros(size(mapping));
for i=1:length(mapping)
    for j=1:4
        if mapping(i,j) ~= 0
            mapped(i,j) = eigvals(mapping(i,j));
        end
    end
end

end

