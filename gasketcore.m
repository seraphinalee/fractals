<<<<<<< HEAD
m=6
=======
m=9
>>>>>>> 99a59294f97040f2b11a7a2ae39b355d0b6e7845
gasket_points = [[0;0] [0;1] [1;1] [1;2] [2;2] [2;0]]
for i = 1:m-1
    gasket_points = repelem(gasket_points,1,3);
    gasket_points = [gasket_points; repmat([0 1 2],1,6*3^(i-1))];
end

gasket_points = [gasket_points; zeros(1,length(gasket_points))];
[a,b,c]=gasketgraph(gasket_points);
scatter3(a,b,c)
