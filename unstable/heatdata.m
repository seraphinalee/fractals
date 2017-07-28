%
%
%
%   A playground script for implementing and collecting data from the
%   heatwave function. The commented block is used for plotting the same t
%   for different values of p
%
%
%
%


% ps = linspace(0.01,0.95,20);
% data = zeros(length(ps),1023);
% meas = zeros(1,length(ps));
% index = 1;
% for p = ps
% [ u,plotting_points ] = heatwave(5,p,0,[10^-8 10^-5 1],[512 1 1023 0],'i','n','h');
% [laplacian,~,points] = laplaciangen(5,p,0,'i','n');
% meas(index) = points(513);
% %surf(u,'LineStyle','none');
% %zlim([-1,200])
% %moviemaker( u,plotting_points);
% data(index,:) = u;
% index = index +1;
% end
% surf(repmat(ps',1,1023),repmat(plotting_points,length(ps),1),data,'LineStyle','none');
% xlabel('p')
% ylabel('x')


[ u,plotting_points ] = heatwave(5,0.49,0,[10^-8 2*10^0 100],[1 10 1000 0],'i','d','w');
moviemaker( u,plotting_points);