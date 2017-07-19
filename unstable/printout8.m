p=0.3;
q=1-p;
cutoff = 0.5;
for m=3:6
[xcors,laplacian] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,V] = fullspectra(laplacian);

l= mod(length(eigvals), 8);
l = (length(eigvals)-l)/8;
for i=1:(l+1)
    for j=1:8
        ind = (i-1)*8+j;
        if (ind < length(eigvals)+1)
            subplot(4,2,j);
            plot(xcors, [0;V(:, ind);0])
            xlabel(strcat('m=', num2str(m),', p=', num2str(p), ', \lambda', num2str(ind), '=', num2str(eigvals(ind))))
        end
    end
    
    
     pause()
     %print('-Plp2ndfloor','-fillpage')
     clf
end
end
