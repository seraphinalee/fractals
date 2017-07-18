p=0.3;
q=1-p;
cutoff = 0.44;
m=3;

[xcors,laplacian] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,V] = fullspectra(laplacian);

for i=1:4
    for j=1:8
        ind = (i-1)*8+j;
        if (ind < length(eigvals)+1)
            subplot(4,2,j);
            plot(xcors, [0;V(:, ind);0])
            xlabel(strcat('p=', num2str(p), ', lambda', num2str(ind), '=', num2str(eigvals(ind))))
        end
    end
    
    

     print('-Plp2ndfloor','-fillpage')
     clf
end

















