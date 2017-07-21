function [] = printout1(m,mu0,r0,r1,cutoff,filename)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[laplacian,plotting_points,points] = laplaciangen(m,mu0,r0,r1,cutoff);
[unique_eigvals,eigvals,V,indices] = fullspectra(laplacian);


subplot(4,2,1);
gasketgraph(plotting_points,V(:,indices(1)))

subplot(4,2,2);
gasketgraph(plotting_points,V(:,indices(2)))

subplot(4,2,3);
gasketgraph(plotting_points,V(:,indices(3)))

subplot(4,2,4);
gasketgraph(plotting_points,V(:,indices(4)))

subplot(4,2,5);
gasketgraph(plotting_points,V(:,indices(5)))

subplot(4,2,6);
gasketgraph(plotting_points,V(:,indices(6)))

subplot(4,2,[7,8]);
plot(log(eigvals),zeros(length(eigvals),1),'o');

print(strcat('.\data\',filename),'-dpng');
dlmwrite(strcat('.\data\',filename),unique_eigvals');
close
end

