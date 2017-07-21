r = 1;
[mu0, mu1, r0, r1] = params(r);
m = 3;

[laplacian,plotting_points,points,cells] = neumanngen(m,mu0, r0, r1,0);
[unique_eigvals, eigvals, V] = fullspectra(laplacian);
V = real(V);

offset = 19;
offset = offset-1;
num = 1;
val = 1000;
f = [zeros(1,offset) val*ones(1,num) zeros(1,length(V)-offset-num)];


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
            R(i,j)=dot(Q(:,i).*v,measure);
            v = v-R(i,j)*Q(:,i);
        end
        R(j,j)=sqrt(dot(v.^2,measure'));
        Q(:,j)=v/R(j,j);
    end
    V(:,index:index-1+unique_eigvals(2,k)) = Q;
    index = index+unique_eigvals(2,k);
end




ts = linspace(10^-3,10^-2,100);



efuncs = permute(V,[3,1,2]);
efuncref = repmat(permute(dot(V,repmat(f'.*measure',1,length(eigvals))),[1 3 2]),1,length(plotting_points),1);
efuncs = efuncs.*efuncref;
efuncs = repmat(efuncs,length(ts),1,1);
evals = repmat(permute(eigvals,[1 3 2]),length(ts),1,1);
%activate this line for heat eqn
evals = repmat(exp(-evals.*repmat(ts',1,1,length(eigvals))),1,length(plotting_points),1);
%and this one for wave eqn
%evals = repmat(sin(sqrt(evals).*repmat(ts',1,1,length(eigvals)))./sqrt(evals),1,length(plotting_points),1);
u = efuncs.*evals;
u = sum(u,3);

% 
% for i=1:length(ts)
%     gasketgraph(plotting_points,u(i,:)');
%     hold on
% end


%v = VideoWriter('sgmaxheat.avi');
%open(v);

F(length(ts)) = struct('cdata',[],'colormap',[]);
for j = 1:length(ts)
   gasketgraph(plotting_points,u(j,:)');
   zlim([-1 10])
   F(j) = getframe;
   %frame = getframe(gcf);
   %writeVideo(v,frame);
end
movie(F,10)
%close(v);
