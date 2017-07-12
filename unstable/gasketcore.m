r = 2;
[mu0, mu1, r0, r1] = params(r);
%search = 4;

%[smalllaplacian,smallplotting_points,smallpoints] = laplaciangen(2,mu0, r0, r1,0);
%[laplacian,plotting_points,points] = neumann(4,mu0, r0, r1,0);
[laplacian,plotting_points,points,cells] = laplaciangen(2,mu0, r0, r1,0);
%[V,D] = partialspectra(laplacian,30);
%r = twin(r);
%[mu0, mu1, r0, r1] = params(r);
[unique_eigvals, eigvals, V] = fullspectra(laplacian);
%[otherlaplacian,plotting_points,points] = laplaciangen(3,mu0, r0, r1,0);

%[unique_eigvals, othereigvals, V] = fullspectra(otherlaplacian);
%a=[eigvals;othereigvals]';
%output = [eigvals;othereigvals]';
%[smallunique_eigvals,smalleigvals,smallV] = fullspectra(smalllaplacian);


%[hits diffs hit_indices] = eigenhunt(smallV(:,smallindices(search)),V,20,points,smallplotting_points);

%subplot(1,2,1)
%gasketgraph(smallplotting_points,-smallV(:,1));
%subplot(1,2,2)
%for i =1:30
%    gasketgraph(plotting_points,V(:,i));
%    pause()
%    clf
%end

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








    







    

