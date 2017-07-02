function [] = printout2(m,mu0,r0,r1,cutoff,filename)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[laplacian,plotting_points,points] = laplaciangen(m,mu0,r0,r1,cutoff);
[unique_eigvals,eigvals,V,indices] = fullspectra(laplacian);


subplot(3,2,1);
peanograph(points,V(:,1),m)
xlabel('eigfunc 1');
subplot(3,2,2);
peanograph(points,V(:,2),m)
xlabel('eigfunc 2');
subplot(3,2,3);
peanograph(points,V(:,3),m)
xlabel('eigfunc 3');
subplot(3,2,4);
peanograph(points,V(:,4),m)
xlabel('eigfunc 4');
subplot(3,2,[5,6]);
plot(eigvals',plotpoints')
xlabel(str);

print(strcat('./data/',filename),'-dpng');
dlmwrite(strcat('./data/',filename),unique_eigvals);
end

