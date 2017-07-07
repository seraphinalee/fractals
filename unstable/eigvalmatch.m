function [ mapping ] = eigvalmatch( prev_mapping, prev_eig_high, eig_high)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(prev_mapping);
mapping = zeros(m,n);

for i = 1: m
    for j = 1:4
        diff = 10000;
        curr_match = 0;
        flag = false;
        disp(prev_mapping(i,j));
        disp(i);
        disp(j);
        disp(' ');
        
        if (prev_mapping(i,j) ~= 0)
        if prev_eig_high(prev_mapping(i,j)) ~= 0
            for k = 1:length(eig_high)
                if (abs(eig_high(k) - prev_eig_high(prev_mapping(i,j))) < diff)
                    diff = abs(eig_high(k) - prev_eig_high(prev_mapping(i,j)));
                    curr_match = k;
                    flag = true;
                end
            end
            if not(flag)
                disp("hi");
                disp(diff);
            end
        end
        end
        
        mapping(i,j) = curr_match;
    end
end

