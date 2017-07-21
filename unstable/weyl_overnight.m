pvals = linspace(0.05, 0.95, 19);
l = length(pvals);
cutoffs = linspace(0.05, 0.95, 19);
m=6;

for i=1:l
    for j=1:l
        p = pvals(i);
        cutoff = cutoffs(j);
        [xcors,laplacian] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
        [x,eigvals,V] = fullspectra(laplacian);
        f = @(x) countingfunction(eigvals,x);
        plotpoints = arrayfun(f,eigvals);
        po = polyfit(log(eigvals),log(plotpoints),1);
        alpha = po(1);
        plot(log(eigvals'),log(plotpoints'./(eigvals').^alpha))
        xlabel(strcat('\alpha=', num2str(alpha), ', m=', num2str(m), ', p=', num2str(p), ', cutoff=', num2str(cutoff)))
        print(strcat('.\weyl\weyl',num2str(i), num2str(j), 'cut', num2str(cutoff)),'-dpng');
        clf
    end
end
