function [] = printout3(r,filename)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[ mu0, mu1, r0, r1 ] = params( r );
[laplacian,~,~] = laplaciangen(3,mu0,r0,r1,0);
[unique_eigvals,eigvals,~,~] = fullspectra(laplacian);

counting_graph(eigvals)
xlabel(strcat('r=',num2str(r),' mu0=',num2str(mu0),' mu1=',num2str(mu1),' r0=',num2str(r0),' r1=',num2str(r1),' L(r)=',num2str(r0*mu0)));
set(gca,'fontsize',6)

print(strcat('./data/',filename),'-dpng');
dlmwrite(strcat('./data/',filename),unique_eigvals');
close
end

