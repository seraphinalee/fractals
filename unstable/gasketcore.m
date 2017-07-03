[laplacian,plotting_points,points] = laplaciangen(1,1/9,9/25,9/25,0);
[unique_eigvals,eigvals,V,indices] = fullspectra(laplacian);

for i =1:length(V)
    gasketgraph(plotting_points,V(:,indices(i)));
    pause()
    close
end
%x = linspace(0.001,0.60,10)
%for i = 1:10
%   printout3(x(i),num2str(i));
%   printout3(twin(x(i)),strcat(num2str(i),'twin'));
%end
%printout3(0.641677,'max');
%printout3(1,'standard');








    







    

