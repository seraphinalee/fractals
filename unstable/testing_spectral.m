eig_lev2 = [(5-sqrt(17))/2, (5-sqrt(5))/2, (5-sqrt(5))/2, (5+sqrt(5))/2, (5+sqrt(5))/2, (5+sqrt(17))/2, 5, 5, 5, 6, 6, 6];

%checking calculations
%plot_v = [eigvals_plot(:, 1); eigvals_plot(:, 2); eigvals_plot(:, 3); eigvals_plot(:, 4)];

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
test = eig_lev4;
val_to_sort = zeros(length(eig_lev2)*4, 1);
for k = 1: length(eig_lev2)
    for l = 1:4
        val_to_sort(4*(k-1)+l) = eig_lev4(k, l);
    end
end

[sorted, I] = sort(val_to_sort); %sorted has been renormalized, by eig_lev4 above


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
[mu0, mu1, r0, r1] = params(1);
[laplacian,plotting_points,points] = laplaciangen(2,mu0, r0, r1,0);
[unique_eigvals, eigvals, V] = fullspectra(laplacian);
[laplacian1,plotting_points1,points1] = laplaciangen(1,mu0, r0, r1,0);
[unique_eigvals1, eigvals1, V1] = fullspectra(laplacian1);
eigvals = eigvals./min(eigvals(eigvals>0));
eigtesting = eigvals;
eigvals1 = eigvals1./min(eigvals1(eigvals1>0));

mapping = eigvalmatch(eig_lev4, sorted', eigvals);
mapped1 = zeros(size(mapping));
for i=1:length(mapping)
    for j=1:4
        if mapping(i,j) ~= 0
            mapped1(i,j) = eigvals(mapping(i,j));
        end
    end
end
plot(eigvals1, mapped1(:,1), 'o', eigvals1, mapped1(:,2), 'o', eigvals1, mapped1(:, 3), 'o', eigvals1, mapped1(:,4), 'o', linspace(0,14), 13.6053.*linspace(0,14).^0.5+185.6642); %for comparison
x = polyfit(sqrt(eigvals1'), mapped1(:,1),1);