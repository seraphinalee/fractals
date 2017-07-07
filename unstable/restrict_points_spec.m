function [ selected_points ] = restrict_points_spec( eigenfunc_high, hashMap, smallplotting_points )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
reduce = @(x) sum((3*ones(length(x),1)).^(linspace(length(x)-1,0,length(x))').*x,1);
num_points = length(smallplotting_points);
selected_points = zeros(num_points,1);

for i=1:num_points
    point = hashMap(reduce(smallplotting_points(:,i)));
    selected_points(i) = eigenfunc_high(point(2));
end

selected_points = selected_points./min(selected_points);
    
end

