function [  ] = eigenval_spectral( r )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[mu0, mu1, r0, r1] = params(r);
num_vals = 12; %check later!!!

[eigvals_1 eigvals_2 eigvals_3 eigvals_4] = zeros(num_vals, 4);
eigvals_small = zeros(num_vals);

for i=1:num_vals
    search = i;

    [smalllaplacian,smallplotting_points,smallpoints] = laplaciangen(1,mu0, r0, r1,0);
    [laplacian,plotting_points,points] = laplaciangen(2,mu0, r0, r1,0);
    %[V,D] = partialspectra(laplacian,20);
    [unique_eigvals, eigvals, V, indices] = fullspectra(laplacian);
    [smallunique_eigvals,smalleigvals,smallV,smallindices] = fullspectra(smalllaplacian);


    [hits diffs hit_indices] = eigenhunt(smallV(:,smallindices(search)),V,20,points,smallplotting_points);
    
    hit_indices = unique(hit_indices);
    
    eigvals_1(i) = eigvals(hit_indices(1));
    eigvals_2(i) = eigvals(hit_indices(2));
    eigvals_3(i) = eigvals(hit_indices(3));
    eigvals_4(i) = eigvals(hit_indices(4));
    
    
end
    
end

