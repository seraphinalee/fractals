p = 0.8;
q = 1-p;
m = 5;
cutoff = 0;

[xcors,laplacian] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,V] = fullspectra(laplacian);
V = [zeros(1,length(V)); V; zeros(1,length(V))];




for i=1:8
    for j=1:8
        subplot(4,2,j)
        ourzeros = zeroplotter(xcors,V(:,(i-1)*8+j))
        xlabel(strcat('p=',num2str(p),'_n=',num2str((i-1)*8+j)))
    end
    %print('-Plp2ndfloor','-fillpage')
    clf
end

















