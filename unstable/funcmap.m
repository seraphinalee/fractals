function [ neweigenfunc,newplotting_points,newpoints,newcells ] = funcmap(eigenfunc,lambda,r,m,plotting_points,points,cells)
%Extendes eigenfunc with eval lambda to next level m, assuming parameter r.


%needs plotting_points,points,cells etc. to get a solid understanding of
%the cell structure (threshold splitting means we don't know much about
%the udnerlying structure)
%To get the next eigenvalue use lambdamap




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
newplotting_points = zeros(2*(m)+1,9*length(plotting_points)+12);
neweigenfunc = zeros(9*length(plotting_points)+12,1);



for i =1:length(cells)
    cell = cells{i};
    if not(isempty(cell))
        address = cell.address;
        buffer = 2*(m)+1-length(address);
        for head = [0 1 2 0 1 2 1 2 0 0 2 0 1 2 1;0 1 2 0 1 2 2 0 1 1 0 1 2 0 2;0 1 2 1 2 0 0 1 2 0 0 1 1 2 2]
            if not(all([head;address]-max([head;address])==0))
                try
                    reduced_address = reduce(primary([head(1)*ones(max(0,buffer-3),1);head;address]));
                    current = newpoints(reduced_address);
                    newpoints(reduced_address) = current + [cell.measure 0];
                catch ME
                    reduced_address = reduce(primary([head(1)*ones(max(0,buffer-3),1);head;address]));
                    newpoints(reduced_address) = [cell.measure index];
                    newplotting_points(:,index) = primary([head(1)*ones(max(0,buffer-3),1);head;address]);
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
        buffer = 2*(m-1)+1-length(address);
        try
            reduced_address = reduce(primary([0*ones(buffer,1);address]));
            current = points(reduced_address);
            x0 = eigenfunc(current(2));
            current = newpoints(reduce(primary([0*ones(buffer+2,1);address])));
            neweigenfunc(current(2)) = x0;
        catch ME
            x0 = 0;
        end
        try
            reduced_address = reduce(primary([1*ones(buffer,1);address]));
            current = points(reduced_address);
            x1 = eigenfunc(current(2));
            current = newpoints(reduce(primary([1*ones(buffer+2,1);address])));
            neweigenfunc(current(2)) = x1;
        catch ME
            x1 = 0;
        end
        try
            reduced_address = reduce(primary([2*ones(buffer,1);address]));
            current = points(reduced_address);
            x2 = eigenfunc(current(2));
            current = newpoints(reduce(primary([2*ones(buffer+2,1);address])));
            neweigenfunc(current(2)) = x2;
        catch ME
            x2 = 0;
        end
        for head = [0 1 2 1 2 0 0 2 0 1 2 1; 0 1 2 2 0 1 1 0 1 2 0 2; 1 2 0 0 1 2 0 0 1 1 2 2]
            reduced_address = reduce(primary([head(1)*ones(max(0,buffer-3),1);head;address]));
            current = newpoints(reduced_address);
            current = current(2);
            if all(head==[0;0;1]) | all(head==[1;1;2]) | all(head==[2;2;0])  %o case
                if all(head==[0;0;1])
                a = x2;
                b = x0;
                c = x1;
                elseif all(head==[1;1;2])
                a = x0;
                b = x1;
                c = x2;
                else
                a = x1;
                b = x0;
                c = x2;
                end
                neweigenfunc(current) = (4*a*(-2+2*r*(lambda-6)+r^2*(lambda-6)+lambda)+2*(b+c)*(-28+30*lambda-10*lambda^2+lambda^3+r^2*(-12+26*lambda-10*lambda^2+lambda^3)+2*r*(-20+30*lambda-10*lambda^2+lambda^3)))/((4-2*(2+3*r)*lambda+(1+r)*lambda^2)*(-30+31*lambda-10*lambda^2+lambda^3+r^2*(-18+27*lambda-10*lambda^2+lambda^3)+2*r*(-26+31*lambda-10*lambda^2+lambda^3)));
            elseif all(head==[1;2;0]) | all(head==[2;0;1]) | all(head==[0;1;2])   %z case
                if all(head==[1;2;0])
                a = x0;
                b = x1;
                c = x2;
                elseif all(head==[2;0;1])
                a = x1;
                b = x0;
                c = x2;
                else
                a = x2;
                b = x0;
                c = x1;
                end
                neweigenfunc(current) = (-2*(b+c)*(8-6*lambda+lambda^2+r^2*(12-8*lambda+lambda^2)+2*r*(14-7*lambda+lambda^2))+4*a*(-22+25*lambda-9*lambda^2+lambda^3+r^2*(-6+19*lambda-9*lambda^2+lambda^3)+2*r*(-12+24*lambda-9*lambda^2+lambda^3)))/((4-2*(2+3*r)*lambda+(1+r)*lambda^2)*(-30+31*lambda-10*lambda^2+lambda^3+r^2*(-18+27*lambda-10*lambda^2+lambda^3)+2*r*(-26+31*lambda-10*lambda^2+lambda^3)));
            else   %y case
                if head(3) == 0
                    a = x0;
                    if head(2) == 1
                        b = x1;
                        c = x2;
                    else
                        b = x2;
                        c = x1;
                    end
                elseif head(3) == 1
                     a = x1;
                     if head(2) == 1
                         b = x0;
                         c = x2;
                     else
                         b = x2;
                         c = x0;
                     end
                elseif head(3) == 2
                     a = x2;
                     if head(2) == 0
                         b = x0;
                         c = x1;
                     else
                         b = x1;
                         c = x0;
                     end
                end
                neweigenfunc(current) = -(2*(a*(((lambda-2)^2)*(15-8*lambda+lambda^2)+(r^2)*(12-56*lambda+45*lambda^2-12*lambda^3+lambda^4)+2*r*(28-78*lambda+50*lambda^2-12*lambda^3+lambda^4))+2*r*(c*(10-r*(lambda-6)-3*lambda)+b*(14-7*lambda+lambda^2+r*(6-7*lambda+lambda^2)))))/((4-2*(2+3*r)*lambda+(1+r)*lambda^2)*(-30+31*lambda-10*lambda^2+lambda^3+r^2*(-18+27*lambda-10*lambda^2+lambda^3)+2*r*(-26+31*lambda-10*lambda^2+lambda^3)));
             end
        end
    end
end






end


