pvals = linspace(0.05, 0.95, 19);
l = length(pvals);
alphas = linspace(0.025, 0.975, 39);
a = length(alphas);
m=6;

for i=1:l
    p = pvals(i);
    [xcors,laplacian] = intervallapgen(m,p,1-p,0); %m,p,q,cutoff
    [x,eigvals,V] = fullspectra(laplacian);
    f = @(x) countingfunction(eigvals,x);
    plotpoints = arrayfun(f,eigvals);
    for j=1:a
        %po = polyfit(log(eigvals),log(plotpoints),1);
        alpha = alphas(j);
        plot(log(eigvals'),log(plotpoints'./(eigvals').^alpha))
        xlabel(strcat('\alpha=', num2str(alpha), ', m=', num2str(m), ', p=', num2str(p)))
        print(strcat('.\weyl\weyl',num2str(i), num2str(j), '-dpng'));
        %pause()
        clf
    end
end
