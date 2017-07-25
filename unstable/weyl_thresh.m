m=6;%this value needs to be even because we are twice iterating
%definitely have to stop at m=8
p=0.8;
q=1-p;

for i=3:10
cutoff = ((i-1)/10)*(p-q)/2+(q/2);

[xcors,laplacian] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,V] = fullspectra(laplacian);

f = @(x) countingfunction(eigvals,x);
plotpoints = arrayfun(f,eigvals);
%po = polyfit(log(eigvals),log(plotpoints),1);
%alpha = po(1);
alpha = 0.41294;
%     alpha = 2*log(3)/log((2*r+1)*(9*r^2+26*r+15)/(2*r*(r+2)));
plot(log(eigvals'),log(plotpoints'./(eigvals').^alpha))
xlabel(strcat('\alpha=', num2str(alpha), ', m=', num2str(m), ', p=', num2str(p), ', cutoff=', num2str(cutoff)))
%xlabel(strcat('r=',num2str(r),' mu0=',num2str(mu0),' mu1=',num2str(mu1),' r0=',num2str(r0),' r1=',num2str(r1),' L(r)=',num2str(r0*mu0)));
%set(gca,'fontsize',6)
print(strcat('.\intweyl\weyl8',num2str(i)),'-dpng');
%clf

end

    
