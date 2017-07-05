[mu0, mu1, r0, r1] = params(1);
search = 4;

[smalllaplacian,smallplotting_points,smallpoints] = laplaciangen(1,mu0, r0, r1,0);
[laplacian,plotting_points,points] = laplaciangen(2,mu0, r0, r1,0);
%[V,D] = partialspectra(laplacian,20);
[unique_eigvals, eigvals, V, indices] = fullspectra(laplacian);
[smallunique_eigvals,smalleigvals,smallV,smallindices] = fullspectra(smalllaplacian);


[hits diffs hit_indices] = eigenhunt(smallV(:,smallindices(search)),V,20,points,smallplotting_points);

%subplot(1,2,1)
%gasketgraph(smallplotting_points,smallV(:,2));
%subplot(1,2,2)
gasketgraph(plotting_points,V(:,2));

% for i =1:20
%     subplot(1,2,1)
%     gasketgraph(smallplotting_points,smallV(:,smallindices(search)))
%     subplot(1,2,2)
%     gasketgraph(plotting_points,hits(:,i));
%     pause()
%     clf
% end

%x = linspace(0.001,0.60,10)
%for i = 1:10
%   printout3(x(i),num2str(i));
%   printout3(twin(x(i)),strcat(num2str(i),'twin'));
%end
%printout3(0.641677,'max');
%printout3(1,'standard');








    







    

