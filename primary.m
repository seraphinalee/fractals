function [ point ] = primary( point )
%takes a point and returns its primary address (passthrough if primary
%already)
%the twin to secondary.m

%looks at the first values...
q = point(1);
flag = false;
%for each listed map...
for i= 2:length(point)
    %looks for the first point that departs from qi
    if point(i) ~= q
        %and sees what direction it goes in, correcting if necesary
        if point(i-1:i) == [1;0]
            point(i-1:i) = [0;1];
            point(1:i-1) = point(i-1);
            return
        end
        if point(i-1:i) == [2;1]
            point(i-1:i) = [1;2];
            point(1:i-1) = point(i-1);
            return
        end
        if point(i-1:i) == [0;2]
            point(i-1:i) = [2;0];
            point(1:i-1) = point(i-1);
            return
        end
        return
    end
end
end

