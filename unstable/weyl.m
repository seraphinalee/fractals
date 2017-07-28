%Script intended for general use surrounding the production of Weyl plots



ps=[0.3 0.7 0.3 0.7 0.7];

[ laplacian,plotting_points,points] = laplaciangen( 5,ps,0,'i','d');
[unique_eigvals,eigvals,V] = fullspectra( laplacian );


f = @(x) countingfunction(eigvals,x);
plotpoints = arrayfun(f,eigvals);
alpha = power(prod(log(4)./log(4./(ps'.*(1-ps')))),1/5);
plot(log(eigvals'),log(plotpoints'./((eigvals').^alpha)));
title(strcat('p=',mat2str(ps),'--','\alpha=',num2str(alpha)))
%print('-Plp2ndfloor','-bestfit')



    
