function [ peano_graph ] = peanographer( V, m, indexMap, j )
%takes in V from laplacian_gen, and m (m should match input to laplacian_gen,
%and returns a row array with the points to be plotted)
%indexMap from laplacian_gen, for hashing purposes
%j means you want the jth eigenfunction, ordered in increasing order of
%eigenvalues; should be of form indices(j), where indices were obtained
%from sort
peano_seq = peano([[2;2] [2;0] [0;1] [1;1] [1;2] [2;0] [0;0] [0;1] [1;2]],m-1);
peano_graph = zeros(length(peano_seq));
for i = 1:length(peano_seq)
    if not(all(peano_seq(:,i)-max(peano_seq(:,i))==0))
       peano_graph(i) = V(indexMap(mat2str(peano_seq(:,i))),j);
    end
end
end

