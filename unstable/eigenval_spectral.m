r=1;
[mu0, mu1, r0, r1] = params(r);

[smalllaplacian,smallplotting_points,smallpoints] = laplaciangen(1,mu0, r0, r1,0);
[smallunique_eigvals,smalleigvals,smallV] = fullspectra(smalllaplacian);
%smalleigvals has eigvals on level 1

num_vals = length(smalleigvals);
[laplacian,plotting_points,points] = laplaciangen(2,mu0, r0, r1,0);
[unique_eigvals, eigvals, V] = fullspectra(laplacian);

%eigvals in level 2 that is closest in eigfunc to level 1
eigvals_plot = zeros(num_vals, 4);

%eigvals in level 1 that corresponds to corresponding rows in eigvals_plot
eigvals_small = zeros(num_vals, 1);


for search=1:num_vals
    [hits, diffs, hit_indices] = eigenhunt(smallV(:,search),V,20,points,smallplotting_points);
    
    %disp(smallV(:, search));
    
    hit_indices = unique(hit_indices);
    
    eigvals_plot(search, 1) = eigvals(hit_indices(1));
    eigvals_plot(search, 2) = eigvals(hit_indices(2));
    eigvals_plot(search, 3) = eigvals(hit_indices(3));
    eigvals_plot(search, 4) = eigvals(hit_indices(4));
    eigvals_small(search) = smalleigvals(search);
    
end

%plot(repmat(eigvals_small,1, 4), eigvals_plot, 'o');
eig_lev2 = [(5-sqrt(17))/2, (5-sqrt(5))/2, (5-sqrt(5))/2, (5+sqrt(5))/2, (5+sqrt(5))/2, (5+sqrt(17))/2, 5, 5, 5, 6, 6, 6];

%checking calculations
plot_v = [eigvals_plot(:, 1); eigvals_plot(:, 2); eigvals_plot(:, 3); eigvals_plot(:, 4)];

eig_lev3 = zeros(length(eig_lev2)*2, 1);


for i=1:length(eig_lev2)
    eig_lev3(2*i-1) = (5+(25-4*eig_lev2(i))^(1/2))/2;
    eig_lev3(2*i) = (5-(25-4*eig_lev2(i))^(1/2))/2;
end

eig_lev4 = zeros(2*length(eig_lev3), 1);
for j=1:length(eq_fst)
    eig_lev4(2*j-1) = (5+(25-4*eig_lev3(j))^(1/2))/2;
    eig_lev4(2*j) = (5-(25-4*eig_lev3(j))^(1/2))/2;
end

eig4 = sort(eig_lev4)./min(eig_lev4);
exp_eig = sort(plot_v)./min(plot_v);

view_eig = zeros(length(eig_lev4), 2);
view_eig(:, 1) = eig4;
view_eig(:, 2) = exp_eig;

plot(ones(length(exp_eig), length(exp_eig)), exp_eig, 'o', zeros(length(eig4), length(eig4)), eig4, 'o');


