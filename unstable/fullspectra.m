function [unique_eigvals,eigvals,V,indices] = fullspectra( laplacian )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[V,D]=eig(laplacian);


[eigvals,indices] = sort(real(diag(D)));
eigvals = eigvals';
unique_eigvals = uniquetol(eigvals,0.01/max(eigvals));
unique_eigvals = [unique_eigvals ;zeros(1,length(unique_eigvals))];
for i =1:length(unique_eigvals)
    unique_eigvals(2,i) = sum(abs(eigvals-unique_eigvals(1,i))<0.01);
end
    
end

