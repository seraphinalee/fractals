p=0.9;
q=1-p;
cutoff = 0;
m=4;

[xcors,laplacian] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,V] = fullspectra(laplacian);
neweigvals = eigvals'

%  ratioanalysis(eigvals,0.01,5,10^-3)
% otherlaplacian = laplacian;
% p=1-p;
% [xcors,laplacian] = intervallapgen(m,p,1-p,0); %m,p,q,cutoff
%  [~,othereigvals,otherV] = fullspectra(laplacian);
% V = [zeros(1, length(V));V;zeros(1,length(V))];
% otherV = [zeros(1, length(otherV));otherV;zeros(1,length(otherV))];
% for i=1:length(V)
%     sin(2*pi*xcors)' -sin(2*pi*xcors)' 
%     [0; resistance(1:end-1)'/max(resistance); 0]
%     subplot(3,1,1)
%     plot(xcors,[V(:,i) otherV(:,i)]) %[0;transform(-otherV(:,i)')';0]])
%     subplot(3,1,2)
%     bar(xcors(2:end),resistance(1:end)')
%     subplot(3,1,3)
%     bar(xcors(2:end),transform(measure(1:end))')
%    xlabel(strcat(num2str(eigvals(i)),'____',num2str(othereigvals(i))))
%    pause()
%    clf
% end

% pvals=[0.5 0.3 0.7 0.1 0.9];
% mvals=[1,2,3,4];
% for j=1:length(pvals)
% p=pvals(j);
% q=1-p;
% for k=1:length(mvals)
% m=mvals(k);
% [xcors,laplacian] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
% [x,eigvals,V] = fullspectra(laplacian);
% for i=1:(length(V)-mod(length(V),6))/6+1
% for l=1:6
%     index=(i-1)*6+l;
%     filename=num2str(i);
%     if(index < length(V)+1)
%         subplot(3,2,l)
%         plot(xcors(1:end),(V(1,index)/abs(V(1,index))).*[0;V(:,index);0])
%         xlabel(strcat("m=",num2str(m), " p=",num2str(p), " \lambda_{",num2str(index),"}=",num2str(eigvals(index))))
%     end
% end
% print(strcat('.\intervaleigfns\', num2str(m), '\', num2str(10*p), '\', filename),'-dpdf', '-bestfit')
% clf
% end
% end
% end

% plot(xcors(1:end),[0;V(:,indices(3));0])


% eigenvalue counting fnc
% counting_graph(eigvals);
% xlabel("m=5 p=0.5")

%log eigenvalue plot
%plot(log(eigvals),zeros(length(eigvals),1),'o')
%xlabel("m=5 p=0.9 q=0.1")

% Weyl Plot
% f = @(x) countingfunction(eigvals,x);
% plotpoints = arrayfun(f,eigvals);
% p = polyfit(log(eigvals),log(plotpoints),1);
% alpha = p(1);
% plot(log(eigvals'),log(plotpoints'./(eigvals').^alpha))
% xlabel("m=5 p=0.1 q=0.9")

%plot(linspace(0,1,4^m)', log([measure'./max(measure) resistance'./max(resistance)]))

