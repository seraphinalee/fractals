function [ point ] = primary( point )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
q = point(1);
for i= 1:length(point)
    if point(i) ~= q
        if point(i-1:i) == [1;0]
            point(i-1:i) = [0;1];
            point(1:i-1) = point(i-1)
            return
        end
        if point(i-1:i) == [2;1]
            point(i-1:i) = [1;2];
            point(1:i-1) = point(i-1)
            return
        end
        if point(i-1:i) == [0;2]
            point(i-1:i) = [2;0];
            point(1:i-1) = point(i-1)
            return
        end
    end
end
end

