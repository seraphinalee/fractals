function [ ] = counting_graph( eigvals )
%plots the counting function, given the eigenvalues
    f = @(x) countingfunction(eigvals,x);
    plotpts = arrayfun(f, eigvals);
    plot(eigvals, plotpts);

end

