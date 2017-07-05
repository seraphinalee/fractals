r=1;
[mu0, mu1, r0, r1] = params(r);


[smalllaplacian,smallplotting_points,smallpoints] = laplaciangen(1,mu0, r0, r1,0);
[smallunique_eigvals,smalleigvals,smallV] = fullspectra(smalllaplacian);
num_vals = length(smalleigvals);
%disp(smallV);
eigvals_plot = zeros(num_vals, 4);
eigvals_small = zeros(num_vals, 1);
%disp(size(eigvals_small));
hitdex = zeros(num_vals, 4);


for search=1:num_vals

    [laplacian,plotting_points,points] = laplaciangen(2,mu0, r0, r1,0);
    %[V,D] = partialspectra(laplacian,20);
    [unique_eigvals, eigvals, V] = fullspectra(laplacian);
    

    [hits, diffs, hit_indices] = eigenhunt(smallV(:,search),V,20,points,smallplotting_points);
    
    %disp(smallV(:, search));
    
    hit_indices = unique(hit_indices);
    
    eigvals_plot(search, 1) = eigvals(hit_indices(1));
    eigvals_plot(search, 2) = eigvals(hit_indices(2));
    eigvals_plot(search, 3) = eigvals(hit_indices(3));
    eigvals_plot(search, 4) = eigvals(hit_indices(4));
    eigvals_small(search) = smalleigvals(1, search);
    
    %disp(hit_indices);
end

%plot(repmat(eigvals_small,1, 4), eigvals_plot, 'o');
plot_v = [eigvals_plot(:, 1); eigvals_plot(:, 2); eigvals_plot(:, 3); eigvals_plot(:, 4)];

eq_fst = zeros(length(eigvals_small)*2, 1);

eigvals_small = (eigvals_small./max(plot_v))*6;
plot_v = (plot_v./max(plot_v))*4.9990;


for i=1:length(eigvals_small)
    eq_fst(2*i-1) = (5+(25-4*eigvals_small(i))^(1/2))/2;
    eq_fst(2*i) = (5-(25-4*eigvals_small(i))^(1/2))/2;
end

eq_snd = zeros(2*length(eq_fst), 1);
for j=1:length(eq_fst)
    eq_snd(2*j-1) = (5+(25-4*eq_fst(j))^(1/2))/2;
    eq_snd(2*j) = (5-(25-4*eq_fst(j))^(1/2))/2;
end

disp(sort(eq_snd));
disp(sort(plot_v));

plot(ones(length(plot_v), length(plot_v)), plot_v, 'o', zeros(length(eq_snd), length(eq_snd)), eq_snd, 'o');


