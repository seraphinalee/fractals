m=5
gasket_points = [[0;0] [0;1] [1;1] [1;2] [2;2] [2;0]]
for i = 1:m-1
    gasket_points = repelem(gasket_points,1,3)
    gasket_points = [gasket_points; repmat([0 1 2],1,6*3^(i-1))]
end

    