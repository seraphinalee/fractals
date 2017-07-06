
m=2; %level


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
%compute eigenfunction/values
[V,D] = eig(laplacian);
[eigvals,indices] = sort(real(diag(D)));

%rescale and plot eigenfnc
eigenfunc = V(:,indices(1));

system = -1*eye(length(eigenfunc));
for i=1:length(eigenfunc)
    try
        denom = resistance(i+1)^2*measure(i)*measure(i+1)*(eigenfunc(i)-eigenfunc(i-1))+resistance(i)^2*measure(i)*measure(i+1)*(eigenfunc(i)-eigenfunc(i+1))-resistance(i)*resistance(i+1)*((measure(i)^2+measure(i+1)^2)*eigenfunc(i)+measure(i)*measure(i+1)*(eigenfunc(i-1)+eigenfunc(i+1)));
        system(i,i+1) = ((measure(i)+measure(i+1))*resistance(i)*resistance(i+1)*eigenfunc(i)*measure(i))/denom;
        system(i,i-1) = ((measure(i)+measure(i+1))*resistance(i)*resistance(i+1)*eigenfunc(i)*measure(i+1))/denom;
    catch ME
       try
           denom = resistance(i+1)^2*measure(i)*measure(i+1)*(eigenfunc(i)-0)+resistance(i)^2*measure(i)*measure(i+1)*(eigenfunc(i)-eigenfunc(i+1))-resistance(i)*resistance(i+1)*((measure(i)^2+measure(i+1)^2)*eigenfunc(i)+measure(i)*measure(i+1)*(0+eigenfunc(i+1)));
           system(i,i+1) = ((measure(i)+measure(i+1))*resistance(i)*resistance(i+1)*eigenfunc(i)*measure(i))/denom;           
       catch ME
           denom = resistance(i+1)^2*measure(i)*measure(i+1)*(eigenfunc(i)-eigenfunc(i-1))+resistance(i)^2*measure(i)*measure(i+1)*(eigenfunc(i)-0)-resistance(i)*resistance(i+1)*((measure(i)^2+measure(i+1)^2)*eigenfunc(i)+measure(i)*measure(i+1)*(eigenfunc(i-1)+0));
           system(i,i-1) = ((measure(i)+measure(i+1))*resistance(i)*resistance(i+1)*eigenfunc(i)*measure(i+1))/denom;
       end
    end
end


system = [1 zeros(1,length(system)-1);system];
X =  linsolve(system,[1;zeros(length(system)-1,1)]);


%V = V*(1/(max(max(V))));
%plot(linspace(0,1,4^m-1)',[V(:,10) (measure(2:end).*(1/max(measure)))'])


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


