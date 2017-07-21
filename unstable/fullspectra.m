function [unique_eigvals,eigvals,V_out] = fullspectra( laplacian )
%given laplacian matrix, gives eigvals and eigfuncs. V_out is sorted by
%eigvals in increasing order.
laplacian = full(laplacian);
[V,D]=eig(laplacian);

%FIXME


[eigvals,indices] = sort(real(diag(D)));
eigvals = eigvals';
unique_eigvals = customunique(eigvals,10^-5);


V_out = zeros(length(V));
V = real(V);
V = V./repmat(max(abs(V)),length(V),1);



for j = 1:length(indices)
    V_out(:, j) = V(:, indices(j));
end

end

