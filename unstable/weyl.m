ps=[10^-5 10^-4 10^-3 10^-2 10^-1 1-10^-1 1-10^-2 1-10^-3 1-10^-4 1-10^-5];
for p = ps
[ laplacian,plotting_points,points] = laplaciangen( 5,p,0,'i','d');
[unique_eigvals,eigvals,V_out] = fullspectra( laplacian );


f = @(x) countingfunction(eigvals,x);
plotpoints = arrayfun(f,eigvals);
alpha = log(4)/log(4/(p*(1-p)));
plot(log(eigvals'),log(plotpoints'./((eigvals').^alpha)));
title(strcat('p=',num2str(p)))
%print('-Plp2ndfloor','-bestfit')
clf
end

    
