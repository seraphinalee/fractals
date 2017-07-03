function [eigfuncs output_diffs] = eigenhunt(eigenfunc,V,n,hashMap,smallplotting_points)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

eigenfunc = eigenfunc./max(abs(eigenfunc));
temp = V./max(abs(V));



dims = size(smallplotting_points);
gasketdata = [smallplotting_points; eigenfunc'];
reduce = @(x) sum((3*ones(length(x),1)).^(linspace(length(x)-1,0,length(x))').*x,1);
gasketdata = [gasketdata(1,:); gasketdata(1,:); gasketdata];
diffs = zeros(1,length(temp));
selected_points = zeros(length(gasketdata),length(temp));
for i =1:length(gasketdata)
    point = hashMap(reduce(gasketdata(1:end-1,i)));
    selected_points(i,:) = temp(point(2),:);
end
for i = 1:length(temp)
    if i ==3
        disp(abs(selected_points(:,i)-eigenfunc));
    end
   diffs(1,i) = min(sum(abs(selected_points(:,i)-eigenfunc),1),sum(abs(selected_points(:,i)+eigenfunc),1));
    end
[output_diffs,indices] = sort(diffs);
output_diffs = output_diffs(1:n);
eigfuncs = zeros(length(temp),n);
for i =1:n
    eigfuncs(:,i) = V(:,indices(i));
end






