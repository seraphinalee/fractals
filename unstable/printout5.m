p = 0.8;
q = 1-p;
m = 5;
cutoff = 0;

[xcors,laplacian] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,V] = fullspectra(laplacian);
V = [zeros(1,length(V)); V; zeros(1,length(V))];
X = zeros(1023)

for i = 1:length(V)
    otherzero = zeroplotter(xcors, V(:,i));
    X(1:i-1, i) = otherzero'; 
    clf
end
    
% otherzero = zeroplotter(xcors,V(:,2))


% for i=1:length(V)   
%     zeroplotter(xcors,V(:,i));
%     plot(xcors,sin(pi*i*xcors));
%     pause()
%     clf
% end















