m=8;%this value needs to be even because we are twice iterating
%definitely have to stop at m=8

loops = 100;
F(loops) = struct('cdata',[],'colormap',[]);
index = 0
for mu0 = linspace(0.1/3,0.9/3,loops)
    index = index + 1;
    %boundary and internal points for point gen
    boundary = [[0;0] [1;1] [2;2]];
    gasket_points = [[0;1] [1;2] [2;0]];

    %iteratively generate points by folding in new boundaries and trifurcating
    for i = 1:m-1
        gasket_points = repelem(gasket_points,1,3);
        gasket_points = [gasket_points boundary; repmat([0 1 2],1,length(gasket_points)/3) [1 2 0]];
        boundary = [boundary ; 0 1 2];
    end
    %a hash table for indexing the address to integers
    %the key is the string of the point address
    indexMap = containers.Map;
    for i=1:length(gasket_points)
        indexMap(mat2str(gasket_points(:,i))) = i;
    end

    %define the laplacian, first with zeros..
    laplacian = zeros(1/2*(3^(m+1)-3));





    %mu0 = 1/9;
    r0 = (3/5)^2;
    r1 = (3/5)^2;
    %mu0 = 1/6;
    %r0 = 0.5;
    %r1 = 1/4;

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
    [V,D]=eigs(laplacian,1,'sm');

    gasket_points = [gasket_points boundary; V(:,1)' 0 0 0];
    [a,b,c]=gasketgraph(gasket_points);
    figure
    scatter3(a,b,c,'.');
    drawnow
    F(index) = getframe;
    close
end
