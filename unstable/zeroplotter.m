function [ourzeros] = zeroplotter(xcors,yvals)
%Plots a graph with zeros

ourzeros = zeros(1,length(yvals));

count = 0;
for i=1:length(yvals)-1
    if yvals(i)*yvals(i+1)<0
        slope = (yvals(i+1)-yvals(i))/(xcors(i+1)-xcors(i));
        count = count + 1;
        ourzeros(count) = xcors(i) - yvals(i)/slope;
    end
end
ourzeros = ourzeros(1:count);

% plot(xcors,[yvals zeros(length(yvals),1)])
% hold on
% plot(ourzeros,zeros(length(ourzeros),1),'ro')
% ylabel(num2str(count))            

















end

