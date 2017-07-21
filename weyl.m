[laplacian,plotting_points] = laplaciangen(3,1/9,9/25,9/25,0);
laplacian = full(laplacian);
[V,D]=eig(laplacian);

eigvals = sort(real(diag(D)));
eigvals = eigvals';

unique_eigvals = uniquetol(eigvals,0.01/max(eigvals));
unique_eigvals = [unique_eigvals ;zeros(1,length(unique_eigvals))];
for i =1:length(unique_eigvals)
    unique_eigvals(2,i) = sum(abs(eigvals-unique_eigvals(1,i))<0.01);
end

f = @(x) countingfunction(eigvals,x);
plotpoints = arrayfun(f,eigvals);
%dlm = fitlm(log(eigvals(round(length(eigvals)/2):end)'),log(plotpoints(round(length(eigvals)/2):end)'),'Intercept',false);
%alpha = table2array(dlm.Coefficients(1,'Estimate'));
r=1;
alpha = 2*log(3)/log((2*r+1)*(9*r^2+26*r+15)/(2*r*(r+2)));
plot(log(eigvals'),log(plotpoints'./((eigvals').^alpha)));


    
