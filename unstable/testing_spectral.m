[mu0, mu1, r0, r1] = params(1.5);
[laplacian,plotting_points,points] = laplaciangen(2,mu0, r0, r1,0);
[unique_eigvals, eigvals, V] = fullspectra(laplacian);
[laplacian1,plotting_points1,points1] = laplaciangen(1,mu0, r0, r1,0);
[unique_eigvals1, eigvals1, V1] = fullspectra(laplacian1);

gasketgraph(plotting_points1, V1(:, 3));

graph_restrict = restrict_points_spec(V(:, 20), points, plotting_points1);

%gasketgraph(plotting_points1, graph_restrict);