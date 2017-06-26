function [X Y Z] = gasketgraph( gasketdata )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
X = zeros(length(gasketdata),1);
Y = zeros(length(gasketdata),1);
Z = zeros(length(gasketdata),1);
f0 = @(x) 1/2*(x-[0.5,tan(60)*0.5]) + [0.5,tan(60)*0.5];
f1 = @(x) 1/2*(x-[1,0]) + [1,0];
f2 = @(x) 1/2*(x-[0,1]) + [0,1];
for i = 1:length(gasketdata)
    if gasketdata(1,i) == 0
        cartesian = [0.5,tan(60)*0.5];
    end
    if gasketdata(1,i) == 1
        cartesian = [1,0];
    end
    if gasketdata(1,i) == 2
        cartesian = [0,1];
    end
    for j = 2:length(gasketdata(:,i))-1
       if gasketdata(j,i) == 0
           cartesian = f0(cartesian);
       end
       if gasketdata(j,i) == 1
           cartesian = f1(cartesian);
       end
       if gasketdata(j,i) == 2
           cartesian = f2(cartesian);
       end
    end
    X(i,1) = cartesian(1);
    Y(i,1) = cartesian(2);
    disp(Z)
    Z(i,1) = gasketdata(end,i);
end
end

