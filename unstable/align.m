function [ input ] = align( input )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%tol to be used
tol = 10^-5;



for i = 1:length(input)-1
   if abs(input(i,1)-input(i,2))>input(i,1)*tol
       input(i:end,:) = [0 input(i,2);input(i:end-1,1) input(i+1:end,2)];
   end
end







end

