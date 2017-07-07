function [unique_eigvals,eigvals,V_out] = fullspectra( laplacian )
%given laplacian matrix, gives eigvals and eigfuncs. V_out is sorted by
%eigvals in increasing order.
laplacian = full(laplacian);
[V,D]=eig(laplacian);


[eigvals,indices] = sort(real(diag(D)));
eigvals = eigvals';
unique_eigvals = uniquetol(eigvals,0.01/max(eigvals));
unique_eigvals = [unique_eigvals ;zeros(1,length(unique_eigvals))];
for i =1:length(unique_eigvals)
    unique_eigvals(2,i) = sum(abs(eigvals-unique_eigvals(1,i))<0.01);
end

V_out = zeros(length(V));
V = V./(max(abs(V)));

for j = 1:length(indices)
    V_out(:, j) = V(:, indices(j));
end

end

