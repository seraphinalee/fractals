
p=0.3;
q=1-p;

cutoff = 0;


[xcors,laplacian] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,dirV] = fullspectra(laplacian);
[xcors,laplacian] = intervalneumgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,neumV] = fullspectra(laplacian);
test = deriv(sin(pi*xcors(2:end-1))',m,p,q,cutoff);
%test1 = deriv(cos(pi*xcors(2:end-1))',m,p,q,cutoff);
test = deriv([test;test(end)],m,p,q,cutoff);

plot(xcors(2:end-1),[dirV(:,1) neumV(1:end,2)])
%plot([test1./test])
