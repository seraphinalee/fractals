p = 0.8;
q = 1-p;
m = 5;
cutoff = 0;

[xcors,laplacian] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,V] = fullspectra(laplacian);
V = [zeros(1,length(V)); V; zeros(1,length(V))];




for i=1:length(V)   
    zeroplotter(xcors,V(:,i));
    plot(xcors,sin(pi*i*xcors));
    pause()
    clf
end















