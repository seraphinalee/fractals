
m=3;
rs = linspace(0.1,0.5,20);
data = zeros(length(rs),193);
data2 = zeros(length(rs),193);

for i = 1:length(rs)
    r = rs(i);
    [mu0, mu1, r0, r1] = params(r);
    [laplacian,plotting_points,points] = laplaciangen(m,mu0, r0, r1,0);
    [unique_eigvals, eigvals, V] = fullspectra(laplacian);
    disp(size(unique_eigvals))
    disp(sum(unique_eigvals(2,:)))
    data(i,:) = unique_eigvals(1,:)';
    data2(i,:) = unique_eigvals(2,:)';
end
rs = repmat(rs',1,193);
data2 = reshape(data2,[],1);
data = log(data);
plot(rs,data)
data = reshape(data,[],1);
rs = reshape(rs,[],1);
hold on
scatter(rs,data,sqrt(data2)*12,'filled')