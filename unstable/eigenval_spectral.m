r=1;
[mu0, mu1, r0, r1] = params(r);


[smalllaplacian,smallplotting_points,smallpoints] = laplaciangen(1,mu0, r0, r1,0);
[smallunique_eigvals,smalleigvals,smallV] = fullspectra(smalllaplacian);
num_vals = length(smallunique_eigvals);

eigvals_plot = zeros(num_vals, 4);
eigvals_small = zeros(num_vals, 1);
disp(size(eigvals_small));
hitdex = zeros(num_vals, 4);


for i=1:num_vals
    search = i;

    [laplacian,plotting_points,points] = laplaciangen(2,mu0, r0, r1,0);
    %[V,D] = partialspectra(laplacian,20);
    [unique_eigvals, eigvals, V] = fullspectra(laplacian);
    

    [hits, diffs, hit_indices] = eigenhunt(smallV(:,smallindices(search)),V,20,points,smallplotting_points);
    
    hit_indices = unique(hit_indices);
    
    eigvals_plot(i, 1) = eigvals(hit_indices(1));
    eigvals_plot(i, 2) = eigvals(hit_indices(2));
    eigvals_plot(i, 3) = eigvals(hit_indices(3));
    eigvals_plot(i, 4) = eigvals(hit_indices(4));
    eigvals_small(i) = smallunique_eigvals(search);
    
    
end

    plot(repmat(eigvals_small,1, 4), eigvals_plot);


