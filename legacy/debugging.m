m=4; %level

p=0.9; %measure parameter
q=0.1; %resistance parameter

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
laplacian = zeros(4^m-1);

for i = 1:4^m-1
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
%compute and sort eigenfunction/values 
[V,D] = eig(laplacian);
[eigvals,indices] = sort(real(diag(D)));
eigfnc = V(:,indices);

%rescale and plot eigenfnc
% V = V*(1/(max(max(V))));
% plot(linspace(0,1,4^m+1)',[0; V(:,indices(2)) ;0])
% xlabel("m=5 p=0.9 q=0.1 eigenfuntion#2")

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
% xlabel("m=5 p=0.1 q=0.9")

%plot(linspace(0,1,4^m)', log([measure'./max(measure) resistance'./max(resistance)]))