p=0.4;
[xcors,laplacian] = intervallapgen(2,p,1-p,0); %m,p,q,cutoff
[~,eigvals,V] = fullspectra(laplacian);

[xcors1,laplacian1] = intervallapgen(1,p,1-p,0); %m,p,q,cutoff
[~,eigvals1,V1] = fullspectra(laplacian1);
len_eig = length(eigvals1);

[xcors2, laplacian2] = intervallapgen(3,p,1-p,0);
[~,eigvals2,V2] = fullspectra(laplacian2);
len_eig2 = length(eigvals2);

for i=1:length(eigvals1)
    
subplot(3,2,1);
if V1(1, i) < 0
    graph = -V1(:, i);
else
    graph = V1(:, i);
end
plot(xcors1, [0;graph;0])
xlabel('parent, p=0.4');

subplot(3,2,3);
if V(1, i) < 0
    graph = -V(:, i);
else
    graph = V(:, i);
end
plot(xcors, [0;graph;0]);
xlabel('child 1');

subplot(3,2,4);
if V(1, (2*(len_eig+1)) - i) < 0
    graph = -V(:, (2*(len_eig+1)) - i);
else
    graph = V(:, (2*(len_eig+1)) - i);
end
plot(xcors, [0;graph;0])
xlabel('child 2');

subplot(3,2,5);
if V(1, ((2*len_eig)+1) + i) < 0
    graph = -V(:, ((2*len_eig)+1) + i);
else
    graph = V(:, ((2*len_eig)+1) + i);
end
plot(xcors, [0;graph;0])
xlabel('child 3');

subplot(3,2,6);
if V(1,(4*(len_eig+1)) - i) < 0
    graph = -V(:,(4*(len_eig+1)) - i);
else
    graph = V(:,(4*(len_eig+1)) - i);
end
plot(xcors, [0;graph;0])
xlabel('child 4');

filename = strcat('parent3 ',num2str(i));

print(strcat('./data/',filename),'-dpng');
%dlmwrite(strcat('./data/',filename),unique_eigvals);
end


