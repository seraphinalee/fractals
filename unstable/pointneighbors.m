function [ neighbors ] = pointneighbors( point )
%given a point's address, we want the address of its four (K is 4-regular)
%neighbors

%find neighboring cells
[cell1,cell2] = pointcells(point);
%get the first digits of the prim/sec addresses
p = primary(point);
q = secondary(point);
p = p(1);
q = q(1);
%use mod arithmetic to rotate to the 2 numbers not used by the input point
%followed by the
%cell adress
neighbors = [primary([mod(p+1,3);cell1]) primary([mod(p+2,3);cell1]) primary([mod(q+1,3);cell2]) primary([mod(q+2,3);cell2]) ];
end

