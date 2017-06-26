m=6;%this value needs to be even
mu0 = 1/9;
r1 = 1;
boundary = [[0;0] [1;1] [2;2]];
gasket_points = [[0;1] [1;2] [2;0]];

for i = 1:m-1
    gasket_points = repelem(gasket_points,1,3);
    gasket_points = [gasket_points boundary; repmat([0 1 2],1,length(gasket_points)/3) [1 2 0]];
    boundary = [boundary ; 0 1 2];
end
indexMap = containers.Map;
for i=1:length(gasket_points)
    indexMap(mat2str(gasket_points(:,i))) = i;
end

laplacian = zeros(1/2*(3^(m+1)-3));
for i = 1:length(gasket_points)
    neighbors = pointneighbors(gasket_points(:,i));
    [cell1,cell2] = pointcells(gasket_points(:,i));
    pointmass = 1/(1/3*(measure(cell1,mu0)+measure(cell2,mu0)));
    for j = 1:4
        if not(all(neighbors(:,j)-max(neighbors(:,j))==0))
            resistance = edgeresistance(gasket_points(:,i),neighbors(:,j),r0,r1);
            laplacian(i,indexMap(mat2str(neighbors(:,j)))) = - pointmass / resistance;
            laplacian(i,i) = laplacian(i,i) + pointmass / resistance;
        end
    end
end
[V,D]=eig(laplacian);

gasket_points = [gasket_points boundary; V(:,1)' 0 0 0];
[a,b,c]=gasketgraph(gasket_points);
scatter3(a,b,c)
