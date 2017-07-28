function [ output_args ] = peanograph( points,z_vals,m)
%Plots the peano graph of z_vals according to the linear ordering points

reduce = @(x) sum((3*ones(length(x),1)).^(linspace(length(x)-1,0,length(x))').*x,1);
peano_seq = peano([[2;2] [2;0] [0;1] [1;1] [1;2] [2;0] [0;0] [0;1] [1;2]],2*m-1);
peano_points = zeros(length(peano_seq),1);
for i = 1:length(peano_seq)
    if not(all(peano_seq(:,i)-max(peano_seq(:,i))==0))
        point = points(reduce(peano_seq(:,i)));
        peano_points(i,1) = z_vals(point(2));
    end
end
plot(peano_points)
end

