%takes in a cell of form [a_1, a_2, ...] where the cell = ...F_{a_2}F_{a_1}(SG)
%mua is measure on the outer cells, mub is measure on the inner cells
%3mua+6mub = 1
function measure = measure(cell, mua)
mub = (1-3*mua)/6;
measure = 1;
for i = 1:len(cell)/2
    if cell(2i-1) == cell(2i)
        measure = measure*mua;
    else
        measure = measure*mub;
    end
end