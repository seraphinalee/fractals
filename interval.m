
[xcors,laplacian] = intervallapgen(4,0.5,0.5,0); %m,p,q,cutoff
[~,eigvals,V] = fullspectra(laplacian);

V = V*(1/(max(max(V))));
plot(xcors(1:end),[0;V(:,1);0])


%plot(xcors(1:end),[0;V(:,indices(3));0])


%eigenvalue counting fnc
%counting_graph(eigvals);
%xlabel("m=4 p=0.4 q=0.6")

%log eigenvalue plot
%plot(log(eigvals),zeros(length(eigvals),1),'o')
%xlabel("m=5 p=0.9 q=0.1")

% Weyl Plot
f = @(x) countingfunction(eigvals,x);
plotpoints = arrayfun(f,eigvals);
p = polyfit(log(eigvals),log(plotpoints),1);
alpha = p(1);
plot(log(eigvals'),log(plotpoints'./(eigvals').^alpha))
% xlabel("m=5 p=0.1 q=0.9")

%plot(linspace(0,1,4^m)', log([measure'./max(measure) resistance'./max(resistance)]))

