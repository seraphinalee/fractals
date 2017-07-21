p = 0.5;
q = 1-p;
m = 5;
cutoff = 0;

[xcors,laplacian] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,V] = fullspectra(laplacian);
V = [zeros(1,length(V)); V; zeros(1,length(V))];
MaxMinX = zeros(1023);
MaxMinY = zeros(1023);

for i = 1:length(V)-2
    disp(i)
    [Maxima,Maxlocs] = findpeaks(V(:,i),xcors');
    [Minima,Minlocs] = findpeaks(-V(:,i),xcors');
    Minima = -Minima;
    [critlocs,indices] = sort([Minlocs;Maxlocs]);
    MaxMinX(1:i,i) = critlocs;
    critys = zeros(length(critlocs),1);
    reference = [Minima;Maxima];
    for j=1:length(critlocs)
        critys(j) = reference(indices(j));
    end
    MaxMinY(1:i,i) = critys;
end
