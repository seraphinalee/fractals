%takes in a cell of form [a_1, a_2, ...] where the cell = ...F_{a_2}F_{a_1}(SG)
%mua is measure on the outer cells, mub is measure on the inner cells
%3mua+6mub = 1
function output = measure(cell, mu0)
mu1 = (1-3*mu0)/6;
output = 1;
for i = 1:length(cell)/2
    if cell(2*i-1) == cell(2*i)
        output = output*mu0;
    else
        output = output*mu1;
    end
end