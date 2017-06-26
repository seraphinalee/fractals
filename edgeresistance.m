function res = edgeresistance( x, y, ra, rb )
%x and y are points
%ra is the resistance on the outer cells, rb is on inner cells

neighbors = pointneighbors(x);
neighbors2 = pointneighbors(y);
is_neighbor = false;

for i=1:len(neighbors)
    if all(neighbors(i)==y)
        is_neighbor = true;
    end
end

if not(is_neighbor)
    res = 0;
    return
end
z = [];
for i=1:len(neighbors)
    for j=1:len(neighbors2)
        if all(neighbors(i) == neighbors2(j))
            z = neighbors(i);
        end
    end
end

%get cell that has x, y, z
%and then do below calculations on that cell

res = 1;
for i = 1:(len(x)-1)/2
    if x(2i) == x(2i+1)
        res = res*ra;
    else
        res = res*rb;
    end
end

end

