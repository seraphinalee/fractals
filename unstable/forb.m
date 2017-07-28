function [ bans ] = forb( r )
%Gives the forbidden eigenvalues associated with parameter r on the gasket



forb1 = (2+3*r-sqrt(8*r+9*r^2))/(1+r);
forb2 = (2+3*r+sqrt(8*r+9*r^2))/(1+r);
temp1 = (2*(7+14*r+19*r^2))/power(10-48*r-264*r^2-376*r^3-174*r^4+24*r^5+28*r^6+3*sqrt(3)*sqrt(-(1+r)^6*(9+134*r+75*r^2+148*r^3+723*r^4+686*r^5+225*r^6)),1/3);
temp2 = power(10-48*r-264*r^2-376*r^3-174*r^4+24*r^5+28*r^6+3*sqrt(3)*sqrt(-(1+r)^6*(9+134*r+75*r^2+148*r^3+723*r^4+686*r^5+225*r^6)),1/3)/(1+r)^2;
forb3 = 1/6*(20+temp1+2*temp2);
forb4 = 1/12*(40-temp1*1j*(sqrt(3)-1j)+2*1j*(sqrt(3)+1j)*temp2);
forb5 = 1/12*(40+temp1*1j*(sqrt(3)+1j)-2*1j*(sqrt(3)-1j)*temp2);
bans = real([forb1 forb2 forb3 forb4 forb5 6]);





end

