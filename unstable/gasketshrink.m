[ laplacian,plotting_points,points,cells ] = laplaciangen(3,1,0,'g','d');
[unique_eigvals,eigvals,V] = fullspectra( laplacian );
save = [plotting_points; ones(1,length(plotting_points)); ones(1,length(plotting_points))];
for i=1:length(V)
gasketgraph(plotting_points,V(:,i))
hold on
save = mod(save+0,3);
gasketgraph(save,-V(:,1))
pause()
clf
end