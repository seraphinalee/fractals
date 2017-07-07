% r=1;
% [mu0, mu1, r0, r1] = params(r);
% 
% [smalllaplacian,smallplotting_points,smallpoints] = laplaciangen(1,mu0, r0, r1,0);
% [smallunique_eigvals,smalleigvals,smallV] = fullspectra(smalllaplacian);
% %smalleigvals has eigvals on level 1
% 
% num_vals = length(smalleigvals);
% [laplacian,plotting_points,points] = laplaciangen(2,mu0, r0, r1,0);
% [unique_eigvals, eigvals, V] = fullspectra(laplacian);
% 
% %eigvals in level 2 that is closest in eigfunc to level 1
% eigvals_plot = zeros(num_vals, 4);
% 
% %eigvals in level 1 that corresponds to corresponding rows in eigvals_plot
% eigvals_small = zeros(num_vals, 1);
% 
% 
% 
% for search=1:num_vals
%     [hits, diffs, hit_indices] = eigenhunt(smallV(:,search),V,20,points,smallplotting_points);
%     
%     %disp(smallV(:, search));
%     
%     hit_indices = unique(hit_indices);
%     
%     eigvals_plot(search, 1) = eigvals(hit_indices(1));
%     eigvals_plot(search, 2) = eigvals(hit_indices(2));
%     eigvals_plot(search, 3) = eigvals(hit_indices(3));
%     eigvals_plot(search, 4) = eigvals(hit_indices(4));
%     eigvals_small(search) = smalleigvals(search);
%     
% end

%plot(repmat(eigvals_small,1, 4), eigvals_plot, 'o');
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

mapping = eigvalmatch(eig_lev4, sorted', eigv
als);
mapped1 = zeros(size(mapping));
for i=1:length(mapping)
    for j=1:4
        if mapping(i,j) ~= 0
            mapped1(i,j) = eigvals(mapping(i,j));
        end
    end
end
plot(eigvals1, mapped1(:,1), 'o', eigvals1, mapped1(:,2), 'o', eigvals1, mapped1(:, 3), 'o', eigvals1, mapped1(:,4), 'o'); %for comparison
disp(mapped1);
for i=1:1000
    sorted = eigvals;
    [mu0, mu1, r0, r1] = params(1+i/1000);
    [laplacian,plotting_points,points] = laplaciangen(2,mu0, r0, r1,0);
    [unique_eigvals, eigvals, V] = fullspectra(laplacian);
    sorted = sorted./min(sorted(sorted > 0));
    eigvals = eigvals./min(eigvals(eigvals > 0));
    mapping = eigvalmatch(mapping, sorted', eigvals);
    mapped = zeros(size(mapping));
    for k=1:length(mapping)
    for j=1:4
        if mapping(k,j) ~= 0
            mapped(k,j) = eigvals(mapping(k,j));
        end
    end
    end
end
disp(1+i/1000)
mapped = zeros(size(mapping));

for i=1:length(mapping)
    for j=1:4
        if mapping(i,j) ~= 0
            mapped(i,j) = eigvals(mapping(i,j));
        end
    end
end

plot(eigvals1, mapped(:,1), eigvals1, mapped(:,2),eigvals1, mapped(:, 3), eigvals1, mapped(:,4));

% 
% 
% %matches eig_lev4 to mapping from previous level to eigvals
% mapping = eigvalmatch(eig_lev4, sorted, eigvals);
% 
% 
% eigvals1 = eigvals1./min(eig_lev4(eig_lev4 > 0));
% 
% mapped = zeros(size(mapping));
% 
% for i=1:length(mapping)
%     for j=1:4
%         if mapping(i,j) ~= 0
%             mapped(i,j) = eigvals(mapping(i,j));
%         end
%     end
% end
% 
% mapped_orig = zeros(size(eig_lev4));
% for i=1:length(eig_lev4)
%     for j=1:4
%         if eig_lev4(i,j) ~= 0
%             mapped_orig(i,j) = sorted(eig_lev4(i,j));
%         end
%     end           
% end
% 
% plot(eigvals1, mapped(:,1), 'o', eigvals1, mapped(:,2), 'o',eigvals1, mapped(:, 3), 'o', eigvals1, mapped(:,4), 'o');
% 
% born = [];
% for i=1:length(eigvals)
%     if not(any(mapping(:) == i))
%         born = [born i];
%     end
% 
% end
% 
% born_values = zeros(length(born), 1);
% for i=1:length(born)
%     born_values(i) = eigvals(born(i));
% end
% born_values = (born_values./max(born_values)).*6;
%plot(ones(length(exp_eig), length(exp_eig)), exp_eig, 'o', zeros(length(eig4), length(eig4)), eig4, 'o');


