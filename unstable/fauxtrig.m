p=0.49;
q=1-p;
cutoff = 0;
m=5;



[xcors,laplacian] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,dirV] = fullspectra(laplacian);
[xcors,laplacian] = intervalneumgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,neumV] = fullspectra(laplacian);


plot(xcors(2:end-1),[neumV(:,2)./dirV(:,1)])