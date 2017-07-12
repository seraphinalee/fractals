r = 1;
m=1;
[mu0, mu1, r0, r1] = params(r);
%search = 4;

[smalllaplacian,plotting_points,points] = laplaciangen(m,mu0, r0, r1,0);
[unique_eigvals, smalleigvals, V] = fullspectra(smalllaplacian);
m=2;
[laplacian,plotting_points,points] = laplaciangen(m,mu0, r0, r1,0);
[unique_eigvals, eigvals, V] = fullspectra(laplacian);
test = [];
for i=1:length(smalleigvals)
    test= [test lambdamap(smalleigvals(i),r,2)];
end
%test = sort(test);
test = [[sort(test) zeros(1,length(eigvals)-length(test))];eigvals]';












% p=0.5;
% q=1-p;
% cutoff = 0;
% m=1;
% [xcors,smalllaplacian] = intervallapgen(m,p,1-p,0); %m,p,q,cutoff
% [~,smalleigvals,smallV] = fullspectra(smalllaplacian);
% m=2;
% [xcors,laplacian] = intervallapgen(m,p,1-p,0); %m,p,q,cutoff
% [~,eigvals,V] = fullspectra(laplacian);
% test = zeros(length(eigvals),1);
% for i=1:length(smalleigvals)
%     test(4*i-3:4*i) = intlambdamap(smalleigvals(i),p,2);
% end
% %test = sort(test);
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