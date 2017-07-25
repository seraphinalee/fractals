function [ laplacian,plotting_points,points,cells] = aselfsim(m,rs,cutoff)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
reduce = @(x) sum((3*ones(length(x),1)).^(linspace(length(x)-1,0,length(x))').*x,1);

[ mu0, mu1, r0, r1 ] = params( rs(1) );

cells = {struct('address',[0;0],'measure',mu0,'resistance',r0) struct('address',[1;1],'measure',mu0,'resistance',r0) struct('address',[2;2],'measure',mu0,'resistance',r0) struct('address',[0;1],'measure',mu1,'resistance',r1) struct('address',[1;0],'measure',mu1,'resistance',r1) struct('address',[0;2],'measure',mu1,'resistance',r1) struct('address',[2;0],'measure',mu1,'resistance',r1) struct('address',[1;2],'measure',mu1,'resistance',r1) struct('address',[2;1],'measure',mu1,'resistance',r1)};
deletions = 0;
for i =2:m
    [ mu0, mu1, r0, r1 ] = params( rs(i) );
    newcells = {};
    for j =1:length(cells)
        splitcell = cells{j};
        if not(isempty(splitcell)) && splitcell.measure>=cutoff^i;
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
laplacian = sparse((3*(length(cells)-deletions)-3)/2,(3*(length(cells)-deletions)-3)/2);


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

end





