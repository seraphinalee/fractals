[smalllaplacian,smallplotting_points,smallpoints] = laplaciangen(1,1/9,9/25,9/25,0);
[laplacian,plotting_points,points] = laplaciangen(2,1/9,9/25,9/25,0);
[unique_eigvals,eigvals,V,indices] = fullspectra(laplacian);
[smallunique_eigvals,smalleigvals,smallV,smallindices] = fullspectra(smalllaplacian);


[hits diffs] = eigenhunt(smallV(:,smallindices(3)),V,5,points,smallplotting_points);



gasketgraph(smallplotting_points,smallV(:,smallindices(2)))

for i =1:5
    gasketgraph(plotting_points,hits(:,i));
    pause()
end



%x = linspace(0.001,0.60,10)
%for i = 1:10
%   printout3(x(i),num2str(i));
%   printout3(twin(x(i)),strcat(num2str(i),'twin'));
%end
%printout3(0.641677,'max');
%printout3(1,'standard');








    







    

