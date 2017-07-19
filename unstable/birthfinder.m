r = 2;
m=1;
[mu0, mu1, r0, r1] = params(r);
%search = 4;

[smalllaplacian,smallplotting_points,smallpoints] = laplaciangen(m,mu0, r0, r1,0);
[unique_eigvals, smalleigvals, V] = fullspectra(smalllaplacian);
m=m+1;
[laplacian,plotting_points,points] = laplaciangen(m,mu0, r0, r1,0);
[unique_eigvals, eigvals, V] = fullspectra(laplacian);
test = [];
for i=1:length(smalleigvals)
%for i=1:1
    test= [test lambdamap(abs(smalleigvals(i)),r,m)];
end
%test = sort(test);

test = align([[sort(test) zeros(1,length(eigvals)-length(test))];eigvals]');
test = [test test(:,2)*(mu0*r0)^m/3*2];