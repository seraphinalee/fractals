function [] = printout3(r,filename)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[ mu0, mu1, r0, r1 ] = params( r );
[laplacian,~,~] = laplaciangen(4,mu0,r0,r1,0);
[unique_eigvals,eigvals,~] = fullspectra(laplacian);

f = @(x) countingfunction(eigvals,x);
plotpoints = arrayfun(f,eigvals);
alpha = 2*log(3)/log((2*r+1)*(9*r^2+26*r+15)/(2*r*(r+2)));


subplot(2,1,1)
plot(log(eigvals'),log(plotpoints'./((eigvals').^alpha)));
subplot(2,1,2)
counting_graph(eigvals)
xlabel(strcat('r=',num2str(r),' mu0=',num2str(mu0),' mu1=',num2str(mu1),' r0=',num2str(r0),' r1=',num2str(r1),' L(r)=',num2str(r0*mu0)));
set(gca,'fontsize',6)

print(strcat('./data/',filename),'-dpng');
save(strcat('./data/',filename),'eigvals');
close
end

