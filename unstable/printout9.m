p=0.3;
q=1-p;
cutoff = 0.5;

for m=3:6
[xcors,laplacian] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,V] = fullspectra(laplacian);
counting_graph(eigvals)
xlabel(strcat('res split ','m=', num2str(m), ', p=', num2str(p)))
%pause()
print('-Plp2ndfloor','-fillpage')
clf

end