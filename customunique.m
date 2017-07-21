function [ output ] = customunique( input,tol)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

output = zeros(1,length(input));
count = 0;
counts = zeros(1,length(input));
slider = 1;
for i=1:length(input)-1
    if abs(input(i)-input(i+1))>abs(input(i)*tol)
        count = count + 1;
        output(count) = input(i); 
        counts(count) = slider;
        slider = 0;
    end
    slider = slider + 1;
end
count = count+1;
output(count) = input(end);
counts(count) = slider;
output = output(1,1:count);
counts = counts(1,1:count);
output = [output; counts];

end

