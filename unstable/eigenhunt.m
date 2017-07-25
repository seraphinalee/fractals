function [eigfuncs output_diffs hit_indices] = eigenhunt(eigenfunc,V,n,hashMap,smallplotting_points)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

reduce = @(x) sum((3*ones(length(x),1)).^(linspace(length(x)-1,0,length(x))').*x,1);

num_to_test = min(size(V));
num_points = length(smallplotting_points);

eigenfunc = eigenfunc./max(eigenfunc);

diffs = zeros(3,num_to_test);
eigfuncs = zeros(length(V),n);
for j =0:2
    rotatepoints = mod(smallplotting_points+j,3);
    rotatepoints = [rotatepoints(1,:); rotatepoints(1,:); rotatepoints];
    selected_points = zeros(num_points,num_to_test);
    for i=1:num_points
        point = hashMap(reduce(rotatepoints(:,i)));
        selected_points(i,:) = V(point(2),:);
    end
    selected_points = selected_points./(repmat(max(selected_points),num_points,1));
    for i=1:num_to_test
       %diffs(j+1,i) =  min(sum(abs(selected_points(:,i)-eigenfunc)),sum(abs(selected_points(:,i)+eigenfunc)));
       diffs(j+1,i) =  1-abs((dot(selected_points(:,i)/norm(selected_points(:,i)),eigenfunc/norm(eigenfunc))));
       
    end
end



diffs = reshape(diffs,1,[]);
[output_diffs,hit_indices] = sort(diffs);
output_diffs = output_diffs(1:n);
for i =1:n
    hit_indices(i) = ceil(hit_indices(i)/3);
    eigfuncs(:,i) = V(:,hit_indices(i));
end
hit_indices = hit_indices(1:n);
        