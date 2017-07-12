function [ output,unscaled ] = lambdamap(lambda,r,m)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[ mu0, mu1, r0, r1 ] = params( r );
lambda = lambda*2/3*(r0*mu0)^(m-1);
forb1 = (2+3*r-sqrt(8*r+9*r^2))/(1+r);
forb2 = (2+3*r+sqrt(8*r+9*r^2))/(1+r);
temp1 = (2*(7+14*r+19*r^2))/power(10-48*r-264*r^2-376*r^3-174*r^4+24*r^5+28*r^6+3*sqrt(3)*sqrt(-(1+r)^6*(9+134*r+75*r^2+148*r^3+723*r^4+686*r^5+225*r^6)),1/3);
temp2 = power(10-48*r-264*r^2-376*r^3-174*r^4+24*r^5+28*r^6+3*sqrt(3)*sqrt(-(1+r)^6*(9+134*r+75*r^2+148*r^3+723*r^4+686*r^5+225*r^6)),1/3)/(1+r)^2;
forb3 = 1/6*(20+temp1+2*temp2);
forb4 = 1/12*(40-temp1*1j*(sqrt(3)-1j)+2*1j*(sqrt(3)+1j)*temp2);
forb5 = 1/12*(40+temp1*1j*(sqrt(3)+1j)-2*1j*(sqrt(3)-1j)*temp2);
p0 = -16*r*lambda-8*r^2*lambda;
p1 = 60+224*r+244*r^2+72*r^3+4*r*lambda+4*r^2*lambda;
p2 = -92-330*r-372*r^2-126*r^3;
p3 = 51+173*r+189*r^2+67*r^3;
p4 = -12-38*r-40*r^2-14*r^3;
p5 = 1+3*r+3*r^2+r^3;
unscaled = roots([p5 p4 p3 p2 p1 p0])';
len = length(unscaled);
for i=1:length(unscaled)
   if sum(abs(unscaled(len-i+1)-real([6 5 2*(2+r)/(1+r) forb1 forb2 forb3 forb4 forb5]))<10^-4)>0
       unscaled = [unscaled(1:len-i) unscaled(len-i+2:end)];
   end
end
output = unscaled/(r0*mu0)^m*3/2;
end

