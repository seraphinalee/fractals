
m=5; %level
p=0.7; %measure parameter
q=0.5; %resistance parameter
measure = [p/2 (1-p)/2 (1-p)/2 p/2]; %base measure split
resistance = [q/2 (1-q)/2 (1-q)/2 q/2]; %base resistance split
%split iteratively...
for i = 2:m
    %do a 4x repelem clone, following with a base unit multiplied
    %to get the desired self similar structure
    measure = repelem(measure,4);
    measure = measure.*repmat([p/2 (1-p)/2 (1-p)/2 p/2],1,length(measure)/4);
    resistance = repelem(resistance,4);
    resistance = resistance.*repmat([q/2 (1-q)/2 (1-q)/2 q/2],1,length(resistance)/4);
end
%declare empty laplacian
laplacian=zeros(4^m-1,4^m-1);
%for each point, assign the proper constants for the diagonal...
for i = 1:4^m-1
    avgmeasure = (measure(i)+measure(i+1))/2;
    laplacian(i,i) = (1/avgmeasure)*(1/resistance(i)+1/resistance(i+1));
end
%... and for the right neighbors
for i = 1:4^m-2
    avgmeasure = (measure(i)+measure(i+1))/2;
    laplacian(i,i+1) = (1/avgmeasure)*(-1/resistance(i+1));
end
%... and for the left neighbors
for i = 2:4^m-1
    avgmeasure = (measure(i)+measure(i+1))/2;
    laplacian(i,i-1) = (1/avgmeasure)*(-1/resistance(i));
end
%compute eigenfunction/values
[V,D] = eig(laplacian);
%rescale and plot
V = V*(1/(max(max(V))));
plot(linspace(0,1,4^m-1)',[V(:,end-1:end) (measure(2:end).*(1/max(measure)))'])


    
    



