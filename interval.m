
m=4;
p=0.5;
q=0.5;
measure = [p/2 (1-p)/2 (1-p)/2 p/2];
resistance = [q/2 (1-q)/2 (1-q)/2 q/2];
for i = 2:m
    measure = repelem(measure,4);
    measure = measure.*repmat([p/2 (1-p)/2 (1-p)/2 p/2],1,length(measure)/4);
    resistance = repelem(resistance,4);
    resistance = resistance.*repmat([q/2 (1-q)/2 (1-q)/2 q/2],1,length(resistance)/4);
end
laplacian=zeros(4^m-1,4^m-1);
for i = 1:4^m-1
    avgmeasure = (measure(i)+measure(i+1))/2;
    laplacian(i,i) = (1/avgmeasure)*(1/resistance(i)+1/resistance(i+1));
end
for i = 1:4^m-2
    avgmeasure = (measure(i)+measure(i+1))/2;
    laplacian(i,i+1) = (1/avgmeasure)*(-1/resistance(i+1));
end
for i = 2:4^m-1
    avgmeasure = (measure(i)+measure(i+1))/2;
    laplacian(i,i-1) = (1/avgmeasure)*(-1/resistance(i));
end
[V,D] = eig(laplacian);
V = V*(1/(max(max(V))));
plot(linspace(0,1,4^m-1)',[V(:,1:100) (resistance(2:end).*(1/max(resistance)))'])


    
    



