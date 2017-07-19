[mu0, mu1, r0, r1] = params(1.2);
m=2;
[ V,D,indexMap ] = laplacian_gen(m, mu0, r0, r1);
[eigvals,indices] = sort(real(diag(D)));
peano_graph = peanographer(-V, m, indexMap, indices(10));

plot(peano_graph);
