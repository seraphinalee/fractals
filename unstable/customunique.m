function [ output ] = customunique( input,tol)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

output = zeros(1,length(input));
count = 0;
for i=1:length(input)-1
    if abs(input(i)-input(i+1))>abs(input(i)*tol)
        count = count + 1;
        output(count) = input(i); 
    end
end
count = count+1;
output(count) = input(end);
output = output(1,1:count);
end

