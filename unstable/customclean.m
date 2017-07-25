function [ output ] = customclean( input,ban,tol)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

output = [];
for i=1:length(input)
    if sum(abs(input(i)-ban)<abs(input(i))*tol)==0
        output = [output input(i)]; 
    end
end

end

