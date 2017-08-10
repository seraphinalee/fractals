%
%
%   This script has become something of a decimation playground. There are
%   lots of different snippets that can work together to help build the
%   picture of decimation on SG. It's younger sibling is "intprintdec" for
%   the interval
%
%
%
%







r=10^4;
m=2;
[ mu0, mu1, r0, r1 ] = params( r );
% [mu0, mu1, r0, r1] = params(r);
% [microlaplacian,mircoplotting_points,micropoints] = laplaciangen(1,mu0, r0, r1,0);
% [microunique_eigvals, microeigvals, V] = fullspectra(microlaplacian);
% m=2;
% microeigvals = [microeigvals; microeigvals*(mu0*r0)*2/3];

%search = 4;

[smalllaplacian,smallplotting_points,smallpoints,smallcells] = laplaciangen( m,r,0,'g','d');
[smallunique_eigvals, smalleigvals, smallV] = fullspectra(smalllaplacian);
m=m+1;
[ laplacian,plotting_points,points,cells ] = laplaciangen( m,r,0,'g','d');
[unique_eigvals, eigvals, V] = fullspectra(laplacian);

%hold on

%gasketgraph(plotting_points,V(:,1))
test = [];
for i=1:length(smalleigvals)
%for i=1:1
     test= [test lambdamap(abs(smalleigvals(i)),r,m)];
end
[a,b] = funcmap(V(:,1),test(1)*2/3*(mu0*r0)^(m+1),r,m+1,plotting_points,points,cells);
gasketgraph(b,-a)

[ mu0, mu1, r0, r1 ] = params( r );
test = [[sort(test) zeros(1,length(eigvals)-length(test))];eigvals]';
test = [test test(:,2)*(mu0*r0)^m/3*2];
smalleigvals = [smalleigvals; smalleigvals*(mu0*r0)^(m-1)/3*2];



% a =repmat(eigvals,120,1)
% b = a'
% a./b
% c = reshape(ans, [], 1)









% 
% p=0.7;
% q=1-p;
% cutoff = 0;
% m=0;
% [xcors,smalllaplacian] = intervallapgen(m,p,1-p,0); %m,p,q,cutoff
% [~,smalleigvals,smallV] = fullspectra(smalllaplacian);
% m=m+1;
% [xcors,laplacian] = intervallapgen(m,p,1-p,0); %m,p,q,cutoff
% [~,eigvals,V] = fullspectra(laplacian);
% test = zeros(length(eigvals),1);
% for i=1:length(smalleigvals)
%     test(4*i-3:4*i) = intlambdamap(smalleigvals(i),p,m);
% end
% test = sort(test);
% test = [test eigvals'];







% plot(xcors(1:end),[0;V(:,1);0])


%plot(xcors(1:end),[0;V(:,indices(3));0])


%eigenvalue counting fnc
%counting_graph(eigvals);
%xlabel("m=4 p=0.4 q=0.6")

%log eigenvalue plot
%plot(log(eigvals),zeros(length(eigvals),1),'o')
%xlabel("m=5 p=0.9 q=0.1")

% % Weyl Plot
% f = @(x) countingfunction(eigvals,x);
% plotpoints = arrayfun(f,eigvals);
% p = polyfit(log(eigvals),log(plotpoints),1);
% alpha = p(1);
% plot(log(eigvals'),log(plotpoints'./(eigvals').^alpha))
% xlabel("m=5 p=0.1 q=0.9")
 
%plot(linspace(0,1,4^m)', log([measure'./max(measure) resistance'./max(resistance)]))