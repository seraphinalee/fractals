function res = edgeresistance( x, y, r0, r1 )
%x and y are points
%r0 is the resistance on the outer cells, r1 is on inner cells

%find the two neighboring cells for each neighbor, and the intersection
[cella cellb] = pointcells(x);
[cell1 cell2] = pointcells(y);
intersection = intersect([cella cellb]', [cell1 cell2]','rows')';


%iterate through by pairs of addresses (first is q)
%same maps gives r0, diff gives r1
res = 1;
for i = 1:(length(intersection))/2
    if intersection(2*i-1) == intersection(2*i)
        res = res*r0;
    else
        res = res*r1;
    end
end

end

