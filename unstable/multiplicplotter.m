X = [];
Y = [];
Z = [];

m=3;
rs = linspace(0.1,10,25);

for i = 1:length(rs)
    r = rs(i);

    [mu0, mu1, r0, r1] = params(r);

    [laplacian,plotting_points,points] = laplaciangen(m,mu0, r0, r1,0);
    [unique_eigvals, eigvals, V] = fullspectra(laplacian);
    X = [X;log(unique_eigvals(1,:)')];
    Y = [Y;log(r)*ones(length(unique_eigvals),1)];
    Z = [Z;log(unique_eigvals(2,:)')];
end

scatter3(X,Y,Z,'filled')