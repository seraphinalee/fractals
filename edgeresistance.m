function res = edgeresistance( x, y, r0, r1 )
%x and y are points
%ra is the resistance on the outer cells, rb is on inner cells

cells = pointcells(x);
cells2 = pointcells(y);
intersection = intersect(cells',cells2','rows')';

res = 1;
for i = 1:(length(intersection)-1)/2
    if intersection(2*i) == intersection(2*i+1)
        res = res*r0;
    else
        res = res*r1;
    end
end

end

