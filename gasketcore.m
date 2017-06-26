m=6;
mu0 = 0.5;
r0 = 1;
r1 = 1;
gasket_points = [[0;0] [0;1] [1;1] [1;2] [2;2] [2;0]];
for i = 1:m-1
    gasket_points = repelem(gasket_points,1,3);
    gasket_points = [gasket_points; repmat([0 1 2],1,6*3^(i-1))];
end

laplacian = zeros(1/2*(3^(m+1)-3));
for i = 1:length(gasket_points)
    disp(gasket_points(i))
    if not(all(gasket_points(:,i)-max(gasket_points(:,i)==0)))
        neighbors = pointneighbors(gasket_points(:,i));
        [cell1,cell2] = pointcells(gasket_points(:,i));
        pointmass = 1/(1/3*(measure(cell1,mu0)+measure(cell2,mu0)));
        for j = 1:4
            laplacian(i,addresstoindex(neighbors(:,j))) = - pointmass / edgeresistance(gasket_points(:,i),neighbors(:,j),r0,r1);
            laplacian(i,i) = laplacian(i,i) + pointmass / edgeresistance(gasket_points(:,i),neighbors(:,j),r0,r1);
        end
    end
end



%gasket_points = [gasket_points; zeros(1,length(gasket_points))];
%[a,b,c]=gasketgraph(gasket_points);
%scatter3(a,b,c)
