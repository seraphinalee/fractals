m=2;%this value needs to be even because we are twice iterating
%definitely have to stop at m=8



%%Name your files here!!! Do not forget!!! Do not overwrite!!!
filename = 'myfilename';


%test values, standard and meaningless ones
mu0 = 1/9;
r0 = (3/5)^2;
r1 = (3/5)^2;
mu1 = 1/6- mu0/2;
%mu0 = 1/6;
%r0 = 0.5;
%r1 = 1/4;




%then for each gasket point...
%V = columns are eigenfunction values at the vertices
%D = diagonal matrix with the corresponding eigenvalues
%indexMap for hashing purposes in peanographer
[ V,D,indexMap ] = laplacian_gen(m, mu0, r0, r1);

%sort according to eigvals (low to high), keeping track of indices
[eigvals123,indices] = sort(real(diag(D)));

%below graphs the counting function
%counting_graph(eigvals);

unique_eigvals = eigval_mult(D);

peano_graph = peanographer(V, m, indexMap, indices(2));
plot(peano_graph);

%subplot(3,2,1);
%plot(peano_graph(:,1))
%xlabel('eigfunc 1');
%subplot(3,2,2);
%plot(peano_graph(:,2))
%xlabel('eigfunc 2');
%subplot(3,2,3);
%plot(peano_graph(:,3))
%xlabel('eigfunc 3');
%subplot(3,2,4);
%plot(peano_graph(:,4))
%xlabel('eigfunc 4');
%subplot(3,2,[5,6]);
%plot(eigvals',plotpoints')
%xlabel(str);

%print(strcat('./data/',filename),'-dpng');
%dlmwrite(strcat('./data/',filename),unique_eigvals);

% [eigvals,indices] = sort(real(diag(D)));
% %here we just walk through a bunch of gasket graphs looking for one that is
% %interesting
% for i=1:100
%    %temp = [gasket_points boundary; V(:,randi(length(V)))' 0 0 0];
%    temp = [gasket_points boundary; V(:,indices(i))' 0 0 0];
%    [a,b,c]=gasketgraph(temp);
%    scatter3(a,b,c,'.')
%    pause()
%    clf
% end


 


%temp = [gasket_points boundary; V(:,10)' 0 0 0];
%[a,b,c]=gasketgraph(temp);
%scatter3(a,b,c,'.')

%plot(log(eigvals),zeros(length(eigvals),1),'o')
