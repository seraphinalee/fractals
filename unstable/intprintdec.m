
p=0.00001;
q=1-p;
cutoff = 0;
m=1;
[xcors,smalllaplacian] = intervallapgen(m,p,1-p,0); %m,p,q,cutoff
[~,smalleigvals,smallV] = fullspectra(smalllaplacian);
m=2;
[xcors,laplacian] = intervallapgen(m,p,1-p,0); %m,p,q,cutoff
[~,eigvals,V] = fullspectra(laplacian);
test = [];
for i=1:length(smalleigvals)
    test = [test intlambdamap(smalleigvals(i),p,2)];
end
test = sort(test);
test = align([[test'; zeros(length(eigvals)-length(test),1)] eigvals']);
test = [test test(:,2)*(p*(1-p)/4)^(m)];







