r = 1;
[mu0, mu1, r0, r1] = params(r);
m = 3;

[laplacian,plotting_points,points,cells] = laplaciangen(m,mu0, r0, r1,0);
[unique_eigvals, eigvals, V] = fullspectra(laplacian);
ts = linspace(10^-12,10^-8,90);
eigvals = repmat(eigvals,length(ts),1);
ts = repmat(ts',1,length(eigvals));
heattrace = sum(exp(-ts.*eigvals),2);
plot(log(ts(:,1)),ts(:,1).^(log(3)/log(5)).*heattrace)

%tbh I don't know if I'm doing this right...



