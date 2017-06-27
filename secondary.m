function [ point ] = secondary( point )
%takes a point and returns its secondary address (passthrough if secondary
%already)
%the twin to primary.m

%find the qi...
q = point(1);
%and goes through each map...
for i= 1:length(point)
    %looking for one that departs from qi
    if point(i) ~= q
        %and adjusting the map to the secondary address
        %as necessary
        if point(i-1:i) == [0;1]
            point(i-1:i) = [1;0];
            point(1:i-1) = point(i-1);
            return
        end
        if point(i-1:i) == [1;2]
            point(i-1:i) = [2;1];
            point(1:i-1) = point(i-1);
            return
        end
        if point(i-1:i) == [2;0]
            point(i-1:i) = [0;2];
            point(1:i-1) = point(i-1);
            return
        end
    end
end
end

