




rvals=[10^-1 10^-2 10^-3 10^-4 10^-5 10^-6 10^-7 10^-8];
mvals=[1,2,3];

for k=1:length(mvals)
    m=mvals(k);
    mkdir('./limiteigfns',num2str(m));
    for j=1:length(rvals)
        r=rvals(j);
        mkdir(strcat('./limiteigfns/',num2str(m)),num2str(abs(log10(r))));
        [ laplacian,plotting_points,points,cells ] = laplaciangen( m,r,0,'g','d');
        [unique_eigvals, eigvals, V] = fullspectra(laplacian);
        for i=1:length(V)
            filename=num2str(i);
            gasketgraph(plotting_points,V(:,i));
            xlabel(strcat("m=",num2str(m), " r=",num2str(r), " \lambda_{",num2str(i),"}=",num2str(eigvals(i))))
            savefig(gcf,strcat('./limiteigfns/', num2str(m), '/', num2str(j), '/', filename, '.fig'))
            clf
        end
    end
end











% 
% 
% pvals=[10^-1 10^-2 10^-3 10^-4 10^-5 10^-6 10^-7 10^-8];
% mvals=[1,2,3,4,5];
% 
% for k=1:length(mvals)
%     m=mvals(k);
%     mkdir('./limiteigfns',num2str(m))
%         for j=1:length(pvals)
%             p=pvals(j);
%             [laplacian,xcors] = laplaciangen(m,p,0,'i','d'); %m,p,q,cutoff
%             [x,eigvals,V] = fullspectra(laplacian);        
%             mkdir(strcat('./limiteigfns/',num2str(m)),num2str(abs(log10(p))))
%             csvwrite(strcat('./limiteigfns/', num2str(m), '/', num2str(abs(log10(p))), '/', 'eigvals.csv'),eigvals')
% %         for i=1:(length(V)-mod(length(V),6))/6+1
% %             for l=1:6
% %                 index=(i-1)*6+l;
% %                 filename=num2str(i);
% %                 if(index < length(V)+1)
% %                     subplot(3,2,l)
% %                     plot(xcors(1:end),(V(1,index)/abs(V(1,index))).*[0;V(:,index);0])
% %                     xlabel(strcat("m=",num2str(m), " p=",num2str(p), " \lambda_{",num2str(index),"}=",num2str(eigvals(index))))
% %                 end
% %             end
% %             print(strcat('.\limiteigfns\', num2str(m), '\', num2str(abs(log10(1-p))), '\', filename),'-dpdf', '-bestfit')
% %             clf
% %         end
%     end
% end