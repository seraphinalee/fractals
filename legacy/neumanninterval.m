
m=5; %level
p=0.5; %measure parameter
q=0.5; %resistance parameter
measure = [p/2 (1-p)/2 (1-p)/2 p/2]; %base measure split
resistance = [q/2 (1-q)/2 (1-q)/2 q/2]; %base resistance split
%split iteratively...
for i = 2:m
    %do a 4x repelem clone, following with a base unit multiplied
    %to get the desired self similar structure
    measure = repelem(measure,4);
    measure = measure.*repmat([p/2 (1-p)/2 (1-p)/2 p/2],1,length(measure)/4);
    resistance = repelem(resistance,4);
    resistance = resistance.*repmat([q/2 (1-q)/2 (1-q)/2 q/2],1,length(resistance)/4);
end
%declare empty laplacian
laplacian=zeros(4^m-1,4^m-1);
%for each point, assign the proper constants for the diagonal...
avgmeasure = (measure(1)+measure(2))/2;
laplacian(1,1) = (1/avgmeasure)*(1/resistance(2));
avgmeasure = (measure(4^m-1)+measure(4^m))/2;
laplacian(4^m-1,4^m-1) = (1/avgmeasure)*(1/resistance(4^m-1));
for i = 2:4^m-2
    avgmeasure = (measure(i)+measure(i+1))/2;
    laplacian(i,i) = (1/avgmeasure)*(1/resistance(i)+1/resistance(i+1));
end
%... and for the right neighbors
for i = 1:4^m-2
    avgmeasure = (measure(i)+measure(i+1))/2;
    laplacian(i,i+1) = (1/avgmeasure)*(-1/resistance(i+1));
end
%... and for the left neighbors
for i = 2:4^m-1
    avgmeasure = (measure(i)+measure(i+1))/2;
    laplacian(i,i-1) = (1/avgmeasure)*(-1/resistance(i));
end
%compute eigenfunction/values
[V,D] = eig(laplacian);
[eigvals,indices] = sort(real(diag(D)));

%rescale and plot eigenfnc
V = V*(1/(max(max(V))));
plot(linspace(0,1,4^m-1)',[V(:,1:5)])


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



