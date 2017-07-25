function [ input ] = align( input,tol)
%ALIGN this function takes in two column vectors and lines the first one to
%the second
%   First column contains only a subset of the second, with some elements
%   missing. Both are sorted. Script lines up corresponding elements with
%   zeros in between


for i = 1:length(input)-1
   if abs(input(i,1)-input(i,2))>input(i,1)*tol
       input(i:end,:) = [0 input(i,2);input(i:end-1,1) input(i+1:end,2)];
   end
end







end

