function [ neighbors ] = pointneighbors( point )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
head = point(1:2);
tail = point(3:end);
neighbors = [primary([head(1);head(1);tail]) primary([head(2);head(2);tail])];
if head == [0;1]
    neighbors = [neighbors primary([2;0;tail]) primary([1;2;tail])];
    return
end
if head == [1;2]
    neighbors = [neighbors primary([0;1;tail]) primary([2;0;tail])];
    return
end
if head == [2;0]
    neighbors = [neighbors primary([0;1;tail]) primary([1;2;tail])];
    return
end
end

