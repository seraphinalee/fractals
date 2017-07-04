function [ unique_eigvals ] = eigval_mult( D )
%takes in D from laplacian_gen, i.e. the diagonal matrix with all the
%eigenvalues, and returns an array where the first row lists the unique
%eigenvalues and the second row lists their corresponding multiplicities
eigvals = sort(real(diag(D)));

eigvals = eigvals';
unique_eigvals = uniquetol(eigvals,0.01/max(eigvals));
unique_eigvals = [unique_eigvals ;zeros(1,length(unique_eigvals))];
for i =1:length(unique_eigvals)
    unique_eigvals(2,i) = sum(abs(eigvals-unique_eigvals(1,i))<0.01);
end

end

