function [ output ] = deriv( func,m,p,q,cutoff)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
func = func';
measure = [p/2 (1-p)/2 (1-p)/2 p/2]; %base measure split
xcors = [0 1/4 1/2 3/4 1];
resistance = [q/2 (1-q)/2 (1-q)/2 q/2]; %base resistance split
%split iteratively...
for i = 2:m
    %do a 4x repelem clone, following with a base unit multiplied
    %to get the desired self similar structure
    newmeas = [];
    newres  = [];
    newxcors = [xcors(1)];
    for j =1:length(measure)
        if measure(j)>=cutoff^i
            newxcors = [newxcors xcors(j)+(xcors(j+1)-xcors(j)).*[1/4 1/2 3/4 1]];
            newmeas = [newmeas measure(j)*[p/2 (1-p)/2 (1-p)/2 p/2]];
            newres = [newres resistance(j)*[q/2 (1-q)/2 (1-q)/2 q/2]];
        else
            newmeas = [newmeas measure(j)];
            newres = [newres resistance(j)];
            newxcors = [newxcors xcors(j+1)];
        end
    end
    measure = newmeas;
    resistance = newres;
    xcors = newxcors;
end

pointmass = zeros(1,length(xcors)-2);
for i = 1:length(xcors)-2
    pointmass(i) = (measure(i)+measure(i+1))/2;
end
disp(size(pointmass))
disp(size(func))
disp(size(resistance))
output = (func(2:end)-func(1:end-1))./resistance(2:end-1)./pointmass(1:end-1);
output = output';
%output = output/(max(abs(output)));
%output = output*output(5,1)/abs(output(5,1));






end

