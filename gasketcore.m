
% r = 6;
% [mu0, mu1, r0, r1] = params(r);
%search = 4;
% m=3;

%[smalllaplacian,smallplotting_points,smallpoints] = laplaciangen(2,mu0, r0, r1,0);
%[laplacian,plotting_points,points] = neumann(4,mu0, r0, r1,0);

% [laplacian,plotting_points,points,cells] = laplaciangen(3,mu0, r0, r1,0);

%[V,D] = partialspectra(laplacian,30);
%r = twin(r);
%[mu0, mu1, r0, r1] = params(r);
% [unique_eigvals, eigvals, V] = fullspectra(laplacian);
% ratioanalysis(eigvals,1.5,3,10^-4);

%[a,b]=lambdamap(eigvals(40),r,3);
%[extension,newplotting_points,newpoints,newcells] = funcmap(V(:,40),min(b),r,3,plotting_points,points,cells);
%[a,b]=lambdamap(min(b),r,4);
%[extension,newplotting_points,~,~] = funcmap(extension,min(b),r,4,newplotting_points,newpoints,newcells);

%[otherlaplacian,plotting_points,points] = laplaciangen(3,mu0, r0, r1,0);

%[unique_eigvals, othereigvals, V] = fullspectra(otherlaplacian);
%a=[eigvals;othereigvals]';
%output = [eigvals;othereigvals]';https://www.sharelatex.com/project/59554e5cfff6aecd3afe874c
%[smallunique_eigvals,smalleigvals,smallV] = fullspectra(smalllaplacian);


%[hits diffs hit_indices] = eigenhunt(smallV(:,smallindices(search)),V,20,points,smallplotting_points);

%subplot(1,2,1)

%gasketgraphred(newplotting_points,extension);
%hold on

% gasketgraph(plotting_points,V(:,40));

rvals=[1,0.641677,0.5,twin(0.5),0.2,twin(0.2)];
mvals=[1,2,3];
for j=1:length(rvals)
r=rvals(j);
[mu0, mu1, r0, r1] = params(r);
for k=1:length(mvals)
m=mvals(k);
[laplacian,plotting_points,points,cells] = laplaciangen(m,mu0, r0, r1,0);
[unique_eigvals, eigvals, V] = fullspectra(laplacian);
% for i=1:(length(V)-mod(length(V),6))/6+1
%  for l=1:6
%     index=(i-1)*6+l;     
%     if(index < length(V)+1)
%         subplot(3,2,l)
%         gasketgraph(plotting_points,V(:,index));
%         xlabel(strcat("m=",num2str(m), " r=",num2str(r), " \lambda_{",num2str(index),"}=",num2str(eigvals(index))))
%     end
for i=1:length(V)
    filename=num2str(i);
    gasketgraph(plotting_points,V(:,i));
    xlabel(strcat("m=",num2str(m), " r=",num2str(r), " \lambda_{",num2str(i),"}=",num2str(eigvals(i))))
    savefig(gcf,strcat('./sgeigfns/', num2str(m), '/', num2str(j), '/', filename, '.fig'))
clf
end
end
end


%subplot(1,2,2)
%for i =1:30
%    gasketgraph(plotting_points,V(:,i));
%    pause()
%    clf
%end

%for i =1:20
%     subplot(1,2,1)
%     gasketgraph(smallplotting_points,smallV(:,smallindices(search)))
%     subplot(1,2,2)
%      gasketgraph(plotting_points,V(:,i));
%     pause()
%     clf
%end

%x = linspace(0.001,0.60,10)
%for i = 1:10
%   printout3(x(i),num2str(i));
%   printout3(twin(x(i)),strcat(num2str(i),'twin'));
%end
%printout3(0.641677,'max');
%printout3(1,'standard');








    







    

