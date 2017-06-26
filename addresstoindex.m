function [ index ] = addresstoindex( address)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
  m = length(address) - 2;
  offset = sum(address(1:2));
if all(address(1:2) == [2;0])
  offset = 5;
end
index = 10;
  index = index + offset*3^m;
index = index + base2dec(num2str(address(3:end))',3);
end

