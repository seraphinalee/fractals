function [ selected_points ] = restrict_points_spec( eigenfunc, eigenfunc_high, hashMap, smallplotting_points )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
reduce = @(x) sum((3*ones(length(x),1)).^(linspace(length(x)-1,0,length(x))').*x,1);

num_points = length(smallplotting_points);

eigenfunc = eigenfunc./max(eigenfunc);

diffs = zeros(3);

for j =0:2
    rotatepoints = mod(smallplotting_points+j,3);
    rotatepoints = [rotatepoints(1,:); rotatepoints(1,:); rotatepoints];
    selected_points = zeros(num_points,1);
    for i=1:num_points
        point = hashMap(reduce(rotatepoints(:,i)));
        selected_points(i,:) = eigenfunc_high(point(2));
    end
    selected_points = selected_points./min(selected_points);
    diffs(j+1) =  1-abs((dot(selected_points/norm(selected_points),eigenfunc/norm(eigenfunc))));
    funcs(:, j+1) = selected_points;
end

[sorted, ind] = sort(diffs);

selected_points = funcs(:, ind(1));
end

