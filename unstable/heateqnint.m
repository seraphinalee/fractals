p=0.5;
q=1-p;
cutoff = 0;
m=5;


[xcors,laplacian,measure] = intervallapgen(m,p,q,0); %m,p,q,cutoff
[~,eigvals,V] = fullspectra(laplacian);
V = [zeros(1,length(V));V;zeros(1,length(V))];
for i=1:length(eigvals)
    V(:,i) = V(:,i)./sqrt(dot(V(:,i).^2,measure'));
end
f = sin(linspace(0,2*pi,length(xcors)));
ts = linspace(0.0000001,0.1,50);



efuncs = permute(V,[3,1,2]);
efuncref = repmat(permute(dot(V,repmat(f'.*measure',1,length(eigvals))),[1 3 2]),1,length(xcors),1);
efuncs = efuncs.*efuncref;
efuncs = repmat(efuncs,length(ts),1,1);
evals = repmat(permute(eigvals,[1 3 2]),length(ts),1,1);
evals = repmat(exp(-evals.*repmat(ts',1,1,length(eigvals))),1,length(xcors),1);
u = efuncs.*evals;
u = sum(u,3);




surf(xcors,ts,squeeze(u),'LineStyle','none')
