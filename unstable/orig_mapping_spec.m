function [ eig_lev4, sorted ] = orig_mapping_spec( eig_lev2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

eig_lev3 = zeros(length(eig_lev2), 2);

for i=1:length(eig_lev2)
    res1 = (5+(25-4*eig_lev2(i))^(1/2))/2;
    res2 = (5-(25-4*eig_lev2(i))^(1/2))/2;
    if (res1 ~= 2 && res1 ~= 5 && res1 ~= 6)
        eig_lev3(i, 1) = res1;
    end
    if (res2 ~= 2 && res2 ~= 5 && res2 ~= 6)
        eig_lev3(i, 2) = res2;
    end
end

eig_lev4 = zeros(length(eig_lev2), 4);
for j=1:length(eig_lev2)
    if eig_lev3(j, 1) ~= 0
        res1 = (5+(25-4*eig_lev3(j, 1))^(1/2))/2;
        res3 = (5-(25-4*eig_lev3(j, 1))^(1/2))/2;
    else
        res1 = 0;
        res3 = 0;
    end
    if eig_lev3(j, 2) ~= 0
        res2 = (5+(25-4*eig_lev3(j, 2))^(1/2))/2;
        res4 = (5-(25-4*eig_lev3(j, 2))^(1/2))/2;
    else
        res2 = 0;
        res4 = 0;
    end
    if (res1 ~= 2 && res1 ~= 5 && res1 ~= 6)
        eig_lev4(j, 1) = res1;
    end
    if (res2 ~= 2 && res2 ~= 5 && res2 ~= 6)
        eig_lev4(j, 2) = res2;
    end
    if (res3 ~= 2 && res3 ~= 5 && res3 ~= 6)
        eig_lev4(j, 3) = res3;
    end
    if (res4 ~= 2 && res4 ~= 5 && res4 ~= 6)
        eig_lev4(j, 4) = res4;
    end

end

eig_lev4 = eig_lev4 ./ min(eig_lev4(eig_lev4 > 0));
val_to_sort = zeros(length(eig_lev2)*4, 1);
for k = 1: length(eig_lev2)
    for l = 1:4
        val_to_sort(4*(k-1)+l) = eig_lev4(k, l);
    end
end

sorted = sort(val_to_sort); %sorted has been renormalized, by eig_lev4 above


for i = 1:length(eig_lev2)
    for j=1:4
        value = eig_lev4(i,j);
        for k = 1:length(sorted)
            if value == sorted(k)
                eig_lev4(i,j) = k;
            end
        end
    end
end
end

