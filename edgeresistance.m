function res = edgeresistance( x, y, ra, rb )
%x and y are points
%ra is the resistance on the outer cells, rb is on inner cells

cells = pointneighbors(x);
cells2 = pointneighbors(y);
intersection = intersect(cells',cells2','rows')';

res = 1;
for i = 1:(length(intersection)-1)/2
    if intersection(2*i) == intersection(2*i+1)
        res = res*ra;
    else
        res = res*rb;
    end
end

end

