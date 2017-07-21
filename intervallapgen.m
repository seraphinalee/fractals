function [xcors, laplacian,pointmass ] = intervallapgen(m,p,q,cutoff )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
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
laplacian = zeros(length(xcors)-2);
for i = 1:length(xcors)-2
    avgmeasure = (measure(i)+measure(i+1))/2;
    pointmass(i) = avgmeasure;
    laplacian(i,i) = (1/avgmeasure)*(1/resistance(i)+1/resistance(i+1));
end
%... and for the right neighbors
for i = 1:length(xcors)-3
    avgmeasure = (measure(i)+measure(i+1))/2;
    laplacian(i,i+1) = (1/avgmeasure)*(-1/resistance(i+1));
end
%... and for the left neighbors
for i = 2:length(xcors)-2
    avgmeasure = (measure(i)+measure(i+1))/2;
    laplacian(i,i-1) = (1/avgmeasure)*(-1/resistance(i));
end
pointmass = [measure(1) pointmass measure(end)];


end

