function [ laplacian,plotting_points,points,cells ] = laplaciangen( m,parameters,cutoff,type,boundary)
%UNTITLED9 Summary of this function goes here
%   m is the level
%   parameters is the single (self-similar) or list of length m
%   (a-self-sim) parameters (r or p for interval or SG)
%   cutoff is cell division cutoff, by measure
%   type is i or g, for interval or gasket
%   boundary is d or n for dirichlet or neumann


if length(parameters) > 1


    if all(type == 'i') && all(boundary == 'd')
        ps = parameters;
        qs = 1 - ps;
        p = ps(1);
        q = qs(1);

        measure = [p/2 (1-p)/2 (1-p)/2 p/2]; %base measure split
        xcors = [0 1/4 1/2 3/4 1];
        resistance = [q/2 (1-q)/2 (1-q)/2 q/2]; %base resistance split
        %split iteratively...
        for i = 2:m
            p = ps(i);
            q = qs(i);
            %do a 4x repelem clone, following with a base unit multiplied
            %to get the desired self similar structure
            newmeas = [];
            newres  = [];
            newxcors = [xcors(1)];
            for j =1:length(measure)
                if measure(j)>=cutoff^i
                    newxcors = [newxcors xcors(j)+(xcors(j+1)-xcors(j)).*[1/4 1/2 3/4 1]];
                    newmeas = [newmeas measure(j)*[p/2 (1-p)/2 (1-p)/2 p/2]];
                    newres = [newres resistance(j)*[q/2 (1-q)/2 (1-q)/2 q/2]];
                else
                    newmeas = [newmeas measure(j)];
                    newres = [newres resistance(j)];
                    newxcors = [newxcors xcors(j+1)];
                end
            end
            measure = newmeas;
            resistance = newres;
            xcors = newxcors;
        end
        pointmass = zeros(1,length(xcors)-2);
        laplacian = zeros(length(xcors)-2);
        for i = 1:length(xcors)-2
            avgmeasure = (measure(i)+measure(i+1))/2;
            pointmass(i) = avgmeasure;
            laplacian(i,i) = (1/avgmeasure)*(1/resistance(i)+1/resistance(i+1));
        end
        %... and for the right neighbors
        for i = 1:length(xcors)-3
            avgmeasure = (measure(i)+measure(i+1))/2;
            laplacian(i,i+1) = (1/avgmeasure)*(-1/resistance(i+1));
        end
        %... and for the left neighbors
        for i = 2:length(xcors)-2
            avgmeasure = (measure(i)+measure(i+1))/2;
            laplacian(i,i-1) = (1/avgmeasure)*(-1/resistance(i));
        end
        plotting_points = xcors;
        points = pointmass;


    elseif all(type == 'i') && all(boundary == 'n')
        ps = parameters;
        qs = 1 - ps;
        p = ps(1);
        q = qs(1);

        measure = [p/2 (1-p)/2 (1-p)/2 p/2]; %base measure split
        xcors = [0 1/4 1/2 3/4 1];
        resistance = [q/2 (1-q)/2 (1-q)/2 q/2]; %base resistance split
        %split iteratively...
        for i = 2:m
            %do a 4x repelem clone, following with a base unit multiplied
            %to get the desired self similar structure
            p = ps(i);
            q = qs(i);
            newmeas = [];
            newres  = [];
            newxcors = [xcors(1)];
            for j =1:length(measure)
                if measure(j)>=cutoff^i
                    newxcors = [newxcors xcors(j)+(xcors(j+1)-xcors(j)).*[1/4 1/2 3/4 1]];
                    newmeas = [newmeas measure(j)*[p/2 (1-p)/2 (1-p)/2 p/2]];
                    newres = [newres resistance(j)*[p/2 (1-p)/2 (1-p)/2 p/2]];
                else
                    newmeas = [newmeas measure(j)];
                    newres = [newres resistance(j)];
                    newxcors = [newxcors xcors(j+1)];
                end
            end
            measure = newmeas;
            resistance = newres;
            xcors = newxcors;
        end
        laplacian = zeros(length(xcors)-2);

        pointmass = zeros(1,length(xcors)-2);
        avgmeasure = (measure(1)+measure(2))/2;
        pointmass(1) = avgmeasure;
        laplacian(1,1) = (1/avgmeasure)*(1/resistance(2));
        avgmeasure = (measure(end-1)+measure(end))/2;
        pointmass(end) = avgmeasure;
        laplacian(end,end) = (1/avgmeasure)*(1/resistance(end));

        for i = 2:length(xcors)-3
            avgmeasure = (measure(i)+measure(i+1))/2;
            laplacian(i,i) = (1/avgmeasure)*(1/resistance(i)+1/resistance(i+1));
            pointmass(i) = avgmeasure;
        end
        %... and for the right neighbors
        for i = 1:length(xcors)-3
            avgmeasure = (measure(i)+measure(i+1))/2;
            laplacian(i,i+1) = (1/avgmeasure)*(-1/resistance(i+1));
        end
        %... and for the left neighbors
        for i = 2:length(xcors)-2
            avgmeasure = (measure(i)+measure(i+1))/2;
            laplacian(i,i-1) = (1/avgmeasure)*(-1/resistance(i));
        end

        plotting_points = xcors;
        points = pointmass;




    elseif all(type == 'g') && all(boundary == 'n')
        reduce = @(x) sum((3*ones(length(x),1)).^(linspace(length(x)-1,0,length(x))').*x,1);
        rs = parameters

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

    elseif all(type == 'g') && all(boundary == 'd')
        reduce = @(x) sum((3*ones(length(x),1)).^(linspace(length(x)-1,0,length(x))').*x,1);
        rs = parameters; 

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
    
    
else
    if all(type == 'i') && all(boundary == 'd')
        p = parameters;
        q = 1-p;
        measure = [p/2 (1-p)/2 (1-p)/2 p/2]; %base measure split
        xcors = [0 1/4 1/2 3/4 1];
        resistance = [q/2 (1-q)/2 (1-q)/2 q/2]; %base resistance split
        %split iteratively...
        for i = 2:m
            %do a 4x repelem clone, following with a base unit multiplied
            %to get the desired self similar structure
            newmeas = [];
            newres  = [];
            newxcors = [xcors(1)];
            for j =1:length(measure)
                if measure(j)>=cutoff^i
                    newxcors = [newxcors xcors(j)+(xcors(j+1)-xcors(j)).*[1/4 1/2 3/4 1]];
                    newmeas = [newmeas measure(j)*[p/2 (1-p)/2 (1-p)/2 p/2]];
                    newres = [newres resistance(j)*[q/2 (1-q)/2 (1-q)/2 q/2]];
                else
                    newmeas = [newmeas measure(j)];
                    newres = [newres resistance(j)];
                    newxcors = [newxcors xcors(j+1)];
                end
            end
            measure = newmeas;
            resistance = newres;
            xcors = newxcors;
        end
        pointmass = zeros(1,length(xcors)-2);
        laplacian = zeros(length(xcors)-2);
        for i = 1:length(xcors)-2
            avgmeasure = (measure(i)+measure(i+1))/2;
            pointmass(i) = avgmeasure;
            laplacian(i,i) = (1/avgmeasure)*(1/resistance(i)+1/resistance(i+1));
        end
        %... and for the right neighbors
        for i = 1:length(xcors)-3
            avgmeasure = (measure(i)+measure(i+1))/2;
            laplacian(i,i+1) = (1/avgmeasure)*(-1/resistance(i+1));
        end
        %... and for the left neighbors
        for i = 2:length(xcors)-2
            avgmeasure = (measure(i)+measure(i+1))/2;
            laplacian(i,i-1) = (1/avgmeasure)*(-1/resistance(i));
        end
        
        plotting_points = xcors;
        points = pointmass;

    elseif all(type == 'i') && all(boundary == 'n')
        p = parameters;
        q = 1-p;
        measure = [p/2 (1-p)/2 (1-p)/2 p/2]; %base measure split
        xcors = [0 1/4 1/2 3/4 1];
        resistance = [q/2 (1-q)/2 (1-q)/2 q/2]; %base resistance split
        %split iteratively...
        for i = 2:m
            %do a 4x repelem clone, following with a base unit multiplied
            %to get the desired self similar structure
            newmeas = [];
            newres  = [];
            newxcors = [xcors(1)];
            for j =1:length(measure)
                if measure(j)>=cutoff^i
                    newxcors = [newxcors xcors(j)+(xcors(j+1)-xcors(j)).*[1/4 1/2 3/4 1]];
                    newmeas = [newmeas measure(j)*[p/2 (1-p)/2 (1-p)/2 p/2]];
                    newres = [newres resistance(j)*[p/2 (1-p)/2 (1-p)/2 p/2]];
                else
                    newmeas = [newmeas measure(j)];
                    newres = [newres resistance(j)];
                    newxcors = [newxcors xcors(j+1)];
                end
            end
            measure = newmeas;
            resistance = newres;
            xcors = newxcors;
        end
        laplacian = zeros(length(xcors)-2);

        pointmass = zeros(1,length(xcors)-2);
        avgmeasure = (measure(1)+measure(2))/2;
        pointmass(1) = avgmeasure;
        laplacian(1,1) = (1/avgmeasure)*(1/resistance(1));
        avgmeasure = (measure(end-1)+measure(end))/2;
        pointmass(end) = avgmeasure;
        laplacian(end,end) = (1/avgmeasure)*(1/resistance(end));

        for i = 2:length(xcors)-3
            avgmeasure = (measure(i)+measure(i+1))/2;
            laplacian(i,i) = (1/avgmeasure)*(1/resistance(i)+1/resistance(i+1));
            pointmass(i) = avgmeasure;
        end
        %... and for the right neighbors
        for i = 1:length(xcors)-3
            avgmeasure = (measure(i)+measure(i+1))/2;
            laplacian(i,i+1) = (1/avgmeasure)*(-1/resistance(i+1));
        end
        %... and for the left neighbors
        for i = 2:length(xcors)-2
            avgmeasure = (measure(i)+measure(i+1))/2;
            laplacian(i,i-1) = (1/avgmeasure)*(-1/resistance(i));
        end

        plotting_points = xcors;
        points = pointmass;

    elseif all(type == 'g') && all(boundary == 'd')
        
        [ mu0, mu1, r0, r1 ] = params( parameters );
        
        reduce = @(x) sum((3*ones(length(x),1)).^(linspace(length(x)-1,0,length(x))').*x,1);

        cells = {struct('address',[0;0],'measure',mu0,'resistance',r0) struct('address',[1;1],'measure',mu0,'resistance',r0) struct('address',[2;2],'measure',mu0,'resistance',r0) struct('address',[0;1],'measure',mu1,'resistance',r1) struct('address',[1;0],'measure',mu1,'resistance',r1) struct('address',[0;2],'measure',mu1,'resistance',r1) struct('address',[2;0],'measure',mu1,'resistance',r1) struct('address',[1;2],'measure',mu1,'resistance',r1) struct('address',[2;1],'measure',mu1,'resistance',r1)};
        deletions = 0;
        for i =2:m
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
        
        
        
        
        

    elseif all(type == 'g') && all(boundary == 'n')
        [ mu0, mu1, r0, r1 ] = params( parameters );
        
        
        reduce = @(x) sum((3*ones(length(x),1)).^(linspace(length(x)-1,0,length(x))').*x,1);

        cells = {struct('address',[0;0],'measure',mu0,'resistance',r0) struct('address',[1;1],'measure',mu0,'resistance',r0) struct('address',[2;2],'measure',mu0,'resistance',r0) struct('address',[0;1],'measure',mu1,'resistance',r1) struct('address',[1;0],'measure',mu1,'resistance',r1) struct('address',[0;2],'measure',mu1,'resistance',r1) struct('address',[2;0],'measure',mu1,'resistance',r1) struct('address',[1;2],'measure',mu1,'resistance',r1) struct('address',[2;1],'measure',mu1,'resistance',r1)};
        deletions = 0;
        for i =2:m
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
                            try
                                neighbordata = points(reduce(primary([mod(q+offset,3)*ones(buffer,1);address])));
                                laplacian(injective_address,injective_address) = laplacian(injective_address,injective_address) + pointmass/resistance;
                                laplacian(injective_address,neighbordata(2)) = laplacian(injective_address,neighbordata(2)) - pointmass/resistance;
                            catch
                                if offset==1
                                    neighbordata = points(reduce(primary([mod(q+2,3)*ones(buffer,1);address])));
                                else
                                    neighbordata = points(reduce(primary([mod(q+1,3)*ones(buffer,1);address])));
                                end
                                laplacian(injective_address,injective_address) = laplacian(injective_address,injective_address) + 1/2*pointmass/resistance;
                                laplacian(injective_address,neighbordata(2)) = laplacian(injective_address,neighbordata(2)) - 1/2*pointmass/resistance;

                            end
                        end
                    end
                end
            end
        end

    end
    
end

end


