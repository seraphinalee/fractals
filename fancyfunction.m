V = linspace(0, 5, 1000);
pts = (2.*V.*(V+2))./((2.*V+1).*(9.*V.^2+26.*V+15));
plot(V, pts);
%max found at 0.641677