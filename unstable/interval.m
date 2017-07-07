[xcors,laplacian] = intervallapgen(4,0.5,0.5,0); %m,p,q,cutoff
[~,eigvals,V] = fullspectra(laplacian);

V = V*(1/(max(max(V))));
plot(xcors(1:end),[0;V(:,1);0])


%eigenvalue counting fnc
%counting_graph(eigvals);
%xlabel("m=4 p=0.4 q=0.6")

%log eigenvalue plot
%plot(log(eigvals),zeros(length(eigvals),1),'o')
%xlabel("m=5 p=0.9 q=0.1")

% Weyl Plot


%f = @(x) countingfunction(eigvals,x);
%plotpoints = arrayfun(f,eigvals);
%dlm = fitlm(log(eigvals(round(length(eigvals)/2):end)'),log(plotpoints(round(length(eigvals)/2):end)'),'Intercept',false);
%alpha = table2array(dlm.Coefficients(1,'Estimate'));
%alpha = alpha(1);
%plot(log(eigvals'),log(plotpoints'./(eigvals').^alpha))

% xlabel("m=4 p=0.4 q=0.6")



