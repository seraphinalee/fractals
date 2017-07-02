m=6;%this value needs to be even because we are twice iterating
%definitely have to stop at m=8



%%Name your files here!!! Do not forget!!! Do not overwrite!!!
filename = 'myfilename';



mu0 = 1/9;
r0 = (3/5)^2;
r1 = (3/5)^2;
mu1 = 1/6- mu0/2;
%mu0 = 1/6;
%r0 = 0.5;
%r1 = 1/4;

%then for each gasket point...
[ V,D ] = laplacian_gen(m, mu0, mu1, r0, r1);


%[eigvals,indices] = sort(real(diag(D)));
%eigvals = eigvals';
%unique_eigvals = uniquetol(eigvals,0.01/max(eigvals));
%unique_eigvals = [unique_eigvals ;zeros(1,length(unique_eigvals))];
%for i =1:length(unique_eigvals)
%    unique_eigvals(2,i) = sum(abs(eigvals-unique_eigvals(1,i))<0.01);
%end
    
%peano_seq = peano([[2;2] [2;0] [0;1] [1;1] [1;2] [2;0] [0;0] [0;1] [1;2]],m-1);
%peano_graph = zeros(length(peano_seq),4);
%for j = 1:4
%    for i = 1:length(peano_seq)
%        if not(all(peano_seq(:,i)-max(peano_seq(:,i))==0))
%            peano_graph(i,j) = V(indexMap(mat2str(peano_seq(:,i))),indices(j));
%        end
%    end
%end

f = @(x) countingfunction(eigvals,x);


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


%here we just walk through a bunch of gasket graphs looking for one that is
%interesting
%for i=1:100
%    %temp = [gasket_points boundary; V(:,randi(length(V)))' 0 0 0];
%    temp = [gasket_points boundary; V(:,indices(i))' 0 0 0];
%    [a,b,c]=gasketgraph(temp);
%    scatter3(a,b,c,'.')
%    pause()
%    clf
%end
 


%temp = [gasket_points boundary; V(:,10)' 0 0 0];
%[a,b,c]=gasketgraph(temp);
%scatter3(a,b,c,'.')

%plot(log(eigvals),zeros(length(eigvals),1),'o')
