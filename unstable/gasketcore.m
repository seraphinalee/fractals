[smalllaplacian,smallplotting_points,smallpoints] = laplaciangen(3,1/9,9/25,9/25,0);
[laplacian,plotting_points,points] = laplaciangen(4,1/9,9/25,9/25,0);
[V,D] = partialspectra(laplacian,20);
[smallunique_eigvals,smalleigvals,smallV,smallindices] = fullspectra(smalllaplacian);


[hits diffs hit_indices] = eigenhunt(smallV(:,smallindices(4)),V,20,points,smallplotting_points);

%subplot(1,2,1)
%gasketgraph(smallplotting_points,smallV(:,2));
%subplot(1,2,2)
%gasketgraph(plotting_points,V(:,2));

for i =1:20
    subplot(1,2,1)
    gasketgraph(smallplotting_points,smallV(:,4))
    subplot(1,2,2)
    gasketgraph(plotting_points,hits(:,i));
    pause()
    clf
end

%x = linspace(0.001,0.60,10)
%for i = 1:10
%   printout3(x(i),num2str(i));
%   printout3(twin(x(i)),strcat(num2str(i),'twin'));
%end
%printout3(0.641677,'max');
%printout3(1,'standard');








    







    

