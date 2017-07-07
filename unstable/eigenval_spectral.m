eig_lev2 = [(5-sqrt(17))/2, (5-sqrt(5))/2, (5-sqrt(5))/2, (5+sqrt(5))/2, (5+sqrt(5))/2, (5+sqrt(17))/2, 5, 5, 5, 6, 6, 6];

[eig_lev4, sorted] = orig_mapping_spec(eig_lev2);

[mu0, mu1, r0, r1] = params(1);
[laplacian,plotting_points,points] = laplaciangen(2,mu0, r0, r1,0);
[unique_eigvals, eigvals, V] = fullspectra(laplacian);
eigvals = eigvals./min(eigvals(eigvals>0));

mapping = eigvalmatch(eig_lev4, sorted', eigvals);
mapped1 = map_to_vals_spec(mapping, eigvals);

%plot(eigvals1, mapped1(:,1), 'o', eigvals1, mapped1(:,2), 'o', eigvals1, mapped1(:, 3), 'o', eigvals1, mapped1(:,4), 'o'); %for comparison

for i=1:1000
    sorted = eigvals;
    [mu0, mu1, r0, r1] = params(1+i/2000);
    [laplacian,plotting_points,points] = laplaciangen(2,mu0, r0, r1,0);
    [unique_eigvals, eigvals, V] = fullspectra(laplacian);
    sorted = sorted./min(sorted(sorted > 0));
    eigvals = eigvals./min(eigvals(eigvals > 0));
    mapping = eigvalmatch(mapping, sorted', eigvals);
    %mapped = map_to_vals_spec(mapping, eigvals);
end
disp(1+i/1000)
mapped = map_to_vals_spec(mapping, eigvals);

[laplacian1,plotting_points1,points1] = laplaciangen(1,mu0, r0, r1,0);
[unique_eigvals1, eigvals1, V1] = fullspectra(laplacian1);

plot(eigvals1, mapped(:,1), 'o', eigvals1, mapped(:,2), 'o', eigvals1, mapped(:, 3), 'o', eigvals1, mapped(:,4), 'o');

x = polyfit(sqrt(eigvals1'), mapped(:,1),1);



