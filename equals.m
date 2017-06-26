function eq = equals(x, y)
%equals fn for points, recursive
if isempty(x) & isempty(y)
    eq = true;
elseif x(1) == y(1)
    equals(x(2:end), y(2:end));
else
    eq = false;
end
