m=3;
r0 = (3/5)^2;
r1 = (3/5)^2;
mu0 = 1/100;
mu1 = 1/6-mu0/2;
cutoff = 0.5/3;

reduce = @(x) sum((3*ones(length(x),1)).^(linspace(length(x)-1,0,length(x))').*x,1);

cells = {struct('address',[0;0],'measure',mu0,'resistance',r0) struct('address',[1;1],'measure',mu0,'resistance',r0) struct('address',[2;2],'measure',mu0,'resistance',r0) struct('address',[0;1],'measure',mu1,'resistance',r1) struct('address',[1;0],'measure',mu1,'resistance',r1) struct('address',[0;2],'measure',mu1,'resistance',r1) struct('address',[2;0],'measure',mu1,'resistance',r1) struct('address',[1;2],'measure',mu1,'resistance',r1) struct('address',[2;1],'measure',mu1,'resistance',r1)};
deletions = 0;
for i =2:m
    newcells = {};
    for j =1:length(cells)
        splitcell = cells{j};
        if not(isempty(splitcell)) && splitcell.measure>cutoff^i;
            meas = splitcell.measure;
            res = splitcell.resistance;
            tail = splitcell.address;
            cells{j} = [];
            deletions = deletions + 1;
            children = {struct('address',[0;0;tail],'measure',mu0*meas,'resistance',r0*res) struct('address',[1;1;tail],'measure',mu0*meas,'resistance',r0*res) struct('address',[2;2;tail],'measure',mu0*meas,'resistance',r0*res) struct('address',[0;1;tail],'measure',mu1*meas,'resistance',r1*res) struct('address',[1;0;tail],'measure',mu1*meas,'resistance',r1*res) struct('address',[0;2;tail],'measure',mu1*meas,'resistance',r1*res) struct('address',[2;0;tail],'measure',mu1*meas,'resistance',r1*res) struct('address',[1;2;tail],'measure',mu1*meas,'resistance',r1*res) struct('address',[2;1;tail],'measure',mu1*meas,'resistance',r1*res)};            
            newcells = [newcells children];
        end
    end
    cells = [cells newcells];
end
points = containers.Map({-10},{[-10,-10]});
index = 1;
plotting_points = zeros(2*m+1,(3*(length(cells)-deletions)-3)/2);

for i =1:length(cells)
    cell = cells{i};
    if not(isempty(cell))
        address = cell.address;
        buffer = 2*m+1-length(address);
        for q =0:2
            if not(all([q;address]-max([q;address])==0))
                try
                    reduced_address = reduce(primary([q*ones(buffer,1);address]));
                    current = points(reduced_address);
                    points(reduced_address) = current + [cell.measure 0];
                catch ME
                    points(reduce(primary([q*ones(buffer,1);address]))) = [cell.measure index];
                    plotting_points(:,index) = primary([q*ones(buffer,1);address]);
                    index = index+1;
                end
            end
        end
    end
end





%define the laplacian, first with zeros..
laplacian = zeros((3*(length(cells)-deletions)-3)/2);


for i = 1:length(cells)
    cell = cells{i};
    if not(isempty(cell))
        address = cell.address;
        buffer = 2*m+1-length(address);
        resistance = cell.resistance;
        for q =0:2
            if not(all([q;address]-max([q;address])==0))
                reduced_address = reduce(primary([q*ones(buffer,1);address]));
                pointdata = points(reduced_address);
                pointmass = 3/pointdata(1);
                injective_address = pointdata(2);
                for offset =1:2
                    laplacian(injective_address,injective_address) = laplacian(injective_address,injective_address) + pointmass/resistance;
                    try
                        neighbordata = points(reduce(primary([mod(q+offset,3)*ones(buffer,1);address])));
                        laplacian(injective_address,neighbordata(2)) = - pointmass/resistance;
                    
                    end
                end
            end
        end
    end
end





%find the eigenvectors/values for the laplacian
[V,D]=eigs(laplacian,1,'sm');


temp = [plotting_points 0*ones(1+2*m,1) 1*ones(1+2*m,1) 2*ones(1+2*m,1); V(:,1)' 0 0 0];
[a,b,c]=gasketgraph(temp);
scatter3(a,b,c,'.')







    







    

