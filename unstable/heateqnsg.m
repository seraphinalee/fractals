r = 1;
[mu0, mu1, r0, r1] = params(r);
m = 3;

[laplacian,plotting_points,points,cells] = laplaciangen(m,mu0, r0, r1,0);
[unique_eigvals, eigvals, V] = fullspectra(laplacian);


offset = 500;
num = 100;
f = [zeros(1,offset) ones(1,num) zeros(1,length(V)-offset-num)];



measure = zeros(1,length(points)-1);
points = points.values;
for i=2:length(points)
    point = points{i};
    measure(1,point(2)) = point(1);
end



index = 1;
for k =1:length(unique_eigvals)
    A = V(:,index:index-1+unique_eigvals(2,k));
    [m,n] = size(A);
    Q = zeros(m,n);
    R = zeros(n,n);
    for j=1:n
        v=A(:,j);
        for i=1:j-1
            R(i,j)=Q(:,i)'*v;
            v = v-R(i,j)*Q(:,i);
        end
        R(j,j)=sqrt(dot(v.^2,measure'));
        Q(:,j)=v/R(j,j);
    end
    V(:,index:index-1+unique_eigvals(2,k)) = Q;
    index = index+unique_eigvals(2,k);
end












ts = linspace(10^-4,5*10^-2,70);



efuncs = permute(V,[3,1,2]);
efuncref = repmat(permute(dot(V,repmat(f'.*measure',1,length(eigvals))),[1 3 2]),1,length(plotting_points),1);
efuncs = efuncs.*efuncref;
efuncs = repmat(efuncs,length(ts),1,1);
evals = repmat(permute(eigvals,[1 3 2]),length(ts),1,1);
evals = repmat(exp(-evals.*repmat(ts',1,1,length(eigvals))),1,length(plotting_points),1);
u = efuncs.*evals;
u = sum(u,3);


% for i=1:length(ts)
%     gasketgraph(plotting_points,u(i,:)');
%     hold on
% end

F(length(ts)) = struct('cdata',[],'colormap',[]);
for j = 1:length(ts)
    gasketgraph(plotting_points,u(j,:)');
    zlim([0 1])
    drawnow
    F(j) = getframe;
end
movie(F,10)