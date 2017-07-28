function [] = printout1(m,mu0,r0,r1,cutoff,filename)
%All "printout#" files are utility scripts that we used for automating
%printing or file generation at some point in time. We're keeping them in
%case such automation is wanted again in the future.

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

