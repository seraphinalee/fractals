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


% ps = linspace(0.1,0.9,10);
% data = zeros(length(ps),1023);
% meas = zeros(1,length(ps));
% index = 1;
% for p = ps
% 
% [laplacian,~,points] = laplaciangen(5,p,0,'i','n');
% meas(index) = points(513);
% [ u,plotting_points ] = heatwave(5,p,0,[10^-8 5*10^-3 1],[512 1 9.7656e-04*1023/points(513) 0],'i','n','h');
% 
% data(index,:) = u;
% index = index +1;
% end
% surf(repmat(ps',1,1023),repmat(plotting_points,length(ps),1),data,'LineStyle','none');
% xlabel('p')
% ylabel('x')


t0 = 10^-4;
tend = 2*10^-0;
ts = 400;


[ u,plotting_points] = heatwave(3,0.01,0,[t0 tend ts],[19 1 10000 0],'g','d','w');



moviesaver( u,plotting_points,'gasketwavelow');





