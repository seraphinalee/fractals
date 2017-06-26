function res = edgeresistance( x, y, ra, rb )
%x and y are points
%ra is the resistance on the outer cells, rb is on inner cells
neighbors = pointneighbors(x);
is_neighbor = false;

for i=1:len(neighbors)
    if equals(y, neighbors(i))
        is_neighbor = true;
    end
end

if not(is_neighbor)
    res = 0;
    return
end

res = 1;
for i = 1:(len(x)-1)/2
    if x(2i) == x(2i+1)
        res = res*ra;
    else
        res = res*rb;
    end
end

end

