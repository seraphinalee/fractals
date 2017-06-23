
m=5;
p=0.5;
q=0.99;
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
    for j = 1:4^m-1
        if i==j
            avgmeasure = (measure(i)+measure(i+1))/2;
            laplacian(i,j) = (1/avgmeasure)*(1/resistance(i)+1/resistance(i+1));
        end
        if i+1==j
            avgmeasure = (measure(i)+measure(i+1))/2;
            laplacian(i,j) = (1/avgmeasure)*(-1/resistance(i+1));
        end
        if i-1==j
            avgmeasure = (measure(i)+measure(i+1))/2;
            laplacian(i,j) = (1/avgmeasure)*(-1/resistance(i));
        end
    end
end
[V,D] = eig(laplacian);
plot(linspace(0,1,4^m-1)',[V(:,1:5)*(1/0.0221)*2^(m-6) (resistance(2:end).*(1/max(resistance)))'])


    
    



