
%
%
%   This script has become something of a decimation playground. There are
%   lots of different snippets that can work together to help build the
%   picture of decimation on the interval. It's older sibling is "printdec" for
%   the gasket
%
%
%
%





p=1-10^-3;
cutoff = 0;
m=3;
[smalllaplacian,smallplotting_points] = laplaciangen(m,p,0,'i','d'); %m,p,q,cutoff
[~,smalleigvals,smallV] = fullspectra(smalllaplacian);
m=m+1;
[laplacian,plotting_points,points] = laplaciangen(m,p,0,'i','d'); %m,p,q,cutoff
[~,eigvals,V] = fullspectra(laplacian);
test = [];
for i=1:length(smalleigvals)
    test = [test intlambdamap(smalleigvals(i),p,m)];
end
test = sort(test)';
test = align([[test; zeros(length(eigvals)-length(test),1)] eigvals'],10^-7);
test = [test test*(p*(1-p)/4)^(m)];
%V = [zeros(1,length(V)); V; zeros(1,length(V))];
%for i=1:length(V)-2
%    plot(V(:,i))
%    pause()
%end


% clf
% a = intfuncmap([0;smallV(:,1);0],eigvals(1)/(4/(p*(1-p)))^m,p);
% plot(plotting_points,a*a(2)/abs(a(2)))
% hold on
% plot(plotting_points,V(1,1)./abs(V(1,1)).*[0;V(:,1);0])
% clf


%V = round(V,1)


for i =[1 2 3 4 8 12 13 16]
    plot(plotting_points,[0;V(:,i);0])
    ylim([-1 1])
    xlabel(num2str(i))
    print('-Plp2ndfloor','-bestfit')
end





