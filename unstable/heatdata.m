
ps = linspace(0.1,0.9,10);
data = zeros(length(ps),1023);

for p = ps
[ u,plotting_points ] = heatwave(5,0.5,0,[10^-4 10^-0 200],[1 10 100 0],'i','d','w');
%surf(u,'LineStyle','none');
%zlim([-1,200])
moviemaker( u,plotting_points);
end




