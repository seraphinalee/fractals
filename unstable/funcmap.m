function [ neweigenfunc,newplotting_points,newpoints,newcells ] = funcmap(eigenfunc,lambda,r,m,plotting_points,points,cells)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here




[ mu0, mu1, r0, r1 ] = params( r );
reduce = @(x) sum((3*ones(length(x),1)).^(linspace(length(x)-1,0,length(x))').*x,1);

newcells = {struct('address',[0;0],'measure',mu0,'resistance',r0) struct('address',[1;1],'measure',mu0,'resistance',r0) struct('address',[2;2],'measure',mu0,'resistance',r0) struct('address',[0;1],'measure',mu1,'resistance',r1) struct('address',[1;0],'measure',mu1,'resistance',r1) struct('address',[0;2],'measure',mu1,'resistance',r1) struct('address',[2;0],'measure',mu1,'resistance',r1) struct('address',[1;2],'measure',mu1,'resistance',r1) struct('address',[2;1],'measure',mu1,'resistance',r1)};
newcells = {};
for j =1:length(cells)
    splitcell = cells{j};
    if not(isempty(splitcell))
        meas = splitcell.measure;
        res = splitcell.resistance;
        tail = splitcell.address;
        children = {struct('address',[0;0;tail],'measure',mu0*meas,'resistance',r0*res) struct('address',[1;1;tail],'measure',mu0*meas,'resistance',r0*res) struct('address',[2;2;tail],'measure',mu0*meas,'resistance',r0*res) struct('address',[0;1;tail],'measure',mu1*meas,'resistance',r1*res) struct('address',[1;0;tail],'measure',mu1*meas,'resistance',r1*res) struct('address',[0;2;tail],'measure',mu1*meas,'resistance',r1*res) struct('address',[2;0;tail],'measure',mu1*meas,'resistance',r1*res) struct('address',[1;2;tail],'measure',mu1*meas,'resistance',r1*res) struct('address',[2;1;tail],'measure',mu1*meas,'resistance',r1*res)};            
        newcells = [newcells children];
    end
end
newpoints = containers.Map({-10},{[-10,-10]});
index = 1;
newplotting_points = zeros(2*m+1,9*length(plotting_points)+12);


for i =1:length(newcells)
    cell = newcells{i};
    if not(isempty(cell))
        address = cell.address;
        buffer = 2*m+1-length(address);
        for q =0:2
            if not(all([q;address]-max([q;address])==0))
                try
                    reduced_address = reduce(primary([q*ones(buffer,1);address]));
                    current = newpoints(reduced_address);
                    newpoints(reduced_address) = current + [cell.measure 0];
                catch ME
                    newpoints(reduce(primary([q*ones(buffer,1);address]))) = [cell.measure index];
                    newplotting_points(:,index) = primary([q*ones(buffer,1);address]);
                    index = index+1;
                end
            end
        end
    end
end






for i =1:length(cells)
    cell = cells{i};
    if not(isempty(cell))
        address = cell.address;
        buffer = 2*m+1-length(address);
        try
            reduced_address = reduce(primary([0*ones(buffer,1);address]));
            current = points(reduced_address);
            x0 = eigenfunc(current(1));
        catch
            x0 = 0;
        end
        try
            reduced_address = reduce(primary([1*ones(buffer,1);address]));
            current = points(reduced_address);
            x1 = eigenfunc(current(1));
        catch
            x1 = 0;
        end
        try
            reduced_address = reduce(primary([2*ones(buffer,1);address]));
            current = points(reduced_address);
            x2 = eigenfunc(current(1));
        catch
            x2 = 0;
        end
        
        
        
        for head = [0 1 2 1 2 0 0 2 0 1 2 2; 0 1 2 2 0 1 1 0 1 2 0 0; 1 2 0 0 1 2 0 0 1 1 2 0]
            reduced_address = reduce(primary([head(1)*ones(max(0,buffer-3),1);head;address]));
            current = points(reduced_address);
            if all(head==[0;0;1]) || all(head==[1;1;2]) || all(head==[2;2;0])  %o case
                if all(head==[0;0;1])
                    a = 
                    b = 
                    c = 
                elseif all(head[1;1;2])
                    a = 
                    b = 
                    c = 
                else
                    a = 
                    b = 
                    c = 
                end
                
                neweigenfunc(current) = _____(a,b,c)
                
            elseif all(head==[1;2;0]) || all(head==[2;0;1]) || all(head==[0;1;2])   %z case
                if all(head==[1;2;0])
                    a = 
                    b = 
                    c = 
                elseif all(head[2;0;1])
                    a = 
                    b = 
                    c = 
                else
                    a = 
                    b = 
                    c = 
                end
                
                neweigenfunc(current) = _____(a,b,c)                
                
                
            
            
            else   %y case
                
                
                
                
            end
            
        end
        
    end
        
end






end


