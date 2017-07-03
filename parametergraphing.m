m=4;
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

mu0vals = linspace(0.01,0.9/3,20);  %fill in the values you want to test here, between 0 and 1/3
%rvals = [0.1 0.5 1 2 5 10]; %fill in the values you want to test here, between 0 and infinity
%rvals = ones(1,length(mu0vals))./(6*mu0vals)-1/2;
rvals = ones(1,length(mu0vals));
data = zeros(length(mu0vals),1/2*(3^(m+1)-3));

for mu0dex = linspace(1,length(rvals),length(rvals))%r vals, a list of indices (1 to n)
    r = rvals(mu0dex);
    mu0 = mu0vals(mu0dex);

    laplacian = zeros(1/2*(3^(m+1)-3));
    r0 = (6*r*(r+2))/(9*r^2+26*r+15);
    r1 = (6*(r+2))/(9*r^2+26*r+15);

    %then for each gasket point...
    for i = 1:length(gasket_points)
        %find the neighbors, and adjacent cells with their measure (pointmass)
        neighbors = pointneighbors(gasket_points(:,i));
        [cell1,cell2] = pointcells(gasket_points(:,i));
        pointmass = 1/(1/3*(measure(cell1,mu0)+measure(cell2,mu0)));
        %for each neighbor...
        for j = 1:4
            %if the neighbor is not a boundary (dirichlet)...
            if not(all(neighbors(:,j)-max(neighbors(:,j))==0))
                %compute the interedge resistance
                resistance = edgeresistance(gasket_points(:,i),neighbors(:,j),r0,r1);
                %assign value for the laplacian, +/- based on direction
                %the daig eventually collects all 4 by addition
                laplacian(i,indexMap(mat2str(neighbors(:,j)))) = - pointmass / resistance;
                laplacian(i,i) = laplacian(i,i) + pointmass / resistance;
            else %special case for boundary points
                %compute the interedge resistance
                resistance = edgeresistance(gasket_points(:,i),neighbors(:,j),r0,r1);
                %assign value for the laplacian, +/- based on direction
                %the daig eventually collects all 4 by addition
                laplacian(i,i) = laplacian(i,i) + pointmass / resistance;     
            end
        end
    end

    %find the eigenvectors/values for the laplacian
    [V,D]=eig(laplacian);


    [eigvals,indices] = sort(real(diag(D)));
    eigvals = eigvals';
    %unique_eigvals = uniquetol(eigvals,0.01/max(eigvals));
    %unique_eigvals = [unique_eigvals ;zeros(1,length(unique_eigvals))];
    %for i =1:length(unique_eigvals)
    %    unique_eigvals(2,i) = sum(abs(eigvals-unique_eigvals(1,i))<0.01);
    %end
    %unique_eigvals = unique_eigvals';
    data(mu0dex,:) = log(eigvals);

end
plot(mu0vals,data)

