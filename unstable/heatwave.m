function [ u,plotting_points ] = heatwave(m,parameters,cutoff,t,init,type,boundary,eqn)
%Solves the heat or wave function on sg or interval
%   t is [t0,tend,numsteps]
%   init is [offset,num,value,bckgd]
%   type is interval or sg, i or g
%   eqn is w for wave or h for heat

[laplacian,plotting_points,points] = laplaciangen( m,parameters,cutoff,type,boundary);
[unique_eigvals, eigvals, V] = fullspectra(laplacian);
if type == 'i'
    plotting_points = plotting_points(2:end-1);
end
f = [init(4)*ones(1,init(1)) init(3)*ones(1,init(2)) init(4)*ones(1,length(V)-init(1)-init(2))];


try
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
catch
    measure = points;
    for i=1:length(eigvals)
        V(:,i) = V(:,i)./sqrt(dot(V(:,i).^2,measure'));
    end
end




ts = linspace(t(1),t(2),t(3));



efuncs = permute(V,[3,1,2]);
efuncref = repmat(permute(dot(V,repmat(f'.*measure',1,length(eigvals))),[1 3 2]),1,length(plotting_points),1);
efuncs = efuncs.*efuncref;
efuncs = repmat(efuncs,length(ts),1,1);
evals = repmat(permute(eigvals,[1 3 2]),length(ts),1,1);
if eqn == 'h'
    evals = repmat(exp(-evals.*repmat(ts',1,1,length(eigvals))),1,length(plotting_points),1);
elseif eqn == 'w'
    evals = repmat(sin(sqrt(evals).*repmat(ts',1,1,length(eigvals)))./sqrt(evals),1,length(plotting_points),1);
end
u = efuncs.*evals;
u = sum(u,3);








end

