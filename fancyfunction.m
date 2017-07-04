%takes the L(r) from Bob's notes, which takes in r and returns the
%renormalization factor from his conjecture. Plots it, from r = 0 to 5.
V = linspace(0, 5, 1000);
pts = (2.*V.*(V+2))./((2.*V+1).*(9.*V.^2+26.*V+15));
plot(V, pts);
%max found at r = 0.641677