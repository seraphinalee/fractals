function [ outputfunc ] = intfuncmap(eigenfunc,lambda,p)
%Extendes eigenfunc with eval lambda to next level m, assuming parameter p.

%To get the next eigenvalue use intlambdamap


outputfunc = zeros(length(eigenfunc)*4-3,1);
for i=1:length(eigenfunc)-1
   x = eigenfunc(i);
   y = eigenfunc(i+1);
   outputfunc(4*i-3) = eigenfunc(i);
   outputfunc(4*i-2) = 2*(p-1)*(2*p*y+x*(-2*p+(lambda-2)^2))/((-4*p+(lambda-2)^2)*(lambda-2));
   outputfunc(4*i-1) = 2*(p-1)*(x+y)/(4*p-(lambda-2)^2);
   outputfunc(4*i) = 2*(p-1)*(2*p*(x-y)+y*(lambda-2)^2)/((-4*p+(lambda-2)^2)*(lambda-2));
end
outputfunc(end) = eigenfunc(end);

end

