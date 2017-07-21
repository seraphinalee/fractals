p=0.3;
q=1-p;
cutoff = p*q/4;
clf
m=5;

[xcors,laplacian] = intervallapgen(m,p,1-p,cutoff);
[x,eigvals,V] = fullspectra(laplacian);
plot(xcors, [0;V(:, 9);0])
hold on

m=6;

[xcors1,laplacian1] = intervallapgen(m,p,1-p,cutoff);
[x,eigvals1,V1] = fullspectra(laplacian1);
%plot(xcors1, [0;V1(:, 16);0])
%plot(xcors1, [0; V1(:, 17);0])
plot(xcors1, [0; V1(:, 33);0])


