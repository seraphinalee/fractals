function [ output,unscaled ] = lambdamap(lambda,r,m)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here



[ mu0, mu1, r0, r1 ] = params( r );


lambda = lambda*2/3*(r0*mu0)^(m-1);

bans = forb(r);

p0 = -16*r*lambda-8*r^2*lambda;
p1 = 60+224*r+244*r^2+72*r^3+4*r*lambda+4*r^2*lambda;
p2 = -92-330*r-372*r^2-126*r^3;
p3 = 51+173*r+189*r^2+67*r^3;
p4 = -12-38*r-40*r^2-14*r^3;
p5 = 1+3*r+3*r^2+r^3;
unscaled = roots([p5 p4 p3 p2 p1 p0])';
f = @(x) p0+p1*x+p2*x^2+p3*x^3+p4*x^4+p5*x^5;
unscaled = ([unscaled fzero(f,0) fzero(f,1) fzero(f,2) fzero(f,3) fzero(f,4) fzero(f,5) fzero(f,6)]);
unscaled = customunique(sort(unscaled),10^-5);
%disp(bans/(mu0*r0)^m*3/2);
unscaled = unscaled(1,:);
%6 5 2*(2+r)/(1+r) 
unscaled = customclean(unscaled, bans,10^-5);

%FIXME
%fix this tol scheme
%large eigenvalues are not being identified as unique under flat tol scheme


output = unscaled/(r0*mu0)^m*3/2;

end

