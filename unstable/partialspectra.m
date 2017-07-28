function [ V,D ] = partialspectra( laplacian,n )
%Gives n smallest eigenfunctions/values of laplacian
%If your laplacian matrix is big enough to slow down full spectra, and you
%only need the first n smallest evals/funcs, this will be a lot faster
[V,D] = eigs(laplacian,n,'sm');
end

