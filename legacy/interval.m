p=0.1;
q=1-p;
cutoff = 0;
m=1;
resistance = [q/2 (1-q)/2 (1-q)/2 q/2]; %base resistance split
measure = [p/2 (1-p)/2 (1-p)/2 p/2]; %base measure split
xcors = [0 1/4 1/2 3/4 1];
%split iteratively...
for i = 2:m
    %do a 4x repelem clone, following with a base unit multiplied
    %to get the desired self similar structure
    newmeas = [];
    newres  = [];
    newxcors = [xcors(1)];
    for j =1:length(measure)
        if measure(j)>=cutoff^(i+1)
            newxcors = [newxcors xcors(j)+(xcors(j+1)-xcors(j)).*[1/4 1/2 3/4 1]];
            newmeas = [newmeas measure(j)*[p/2 (1-p)/2 (1-p)/2 p/2]];
            newres = [newres resistance(j)*[q/2 (1-q)/2 (1-q)/2 q/2]];
        else
            newmeas = [newmeas measure(j)];
            newres = [newres resistance(j)];
            newxcors = [newxcors xcors(j+1)];
        end
    end
    measure = newmeas;
    resistance = newres;
    xcors = newxcors;
end

[xcors,laplacian] = intervallapgen(m,p,1-p,0); %m,p,q,cutoff
[~,eigvals,V] = fullspectra(laplacian);
% p=1-p;
% [xcors,laplacian] = intervallapgen(m,p,1-p,0); %m,p,q,cutoff
% [~,othereigvals,otherV] = fullspectra(laplacian);
% V = [zeros(1, length(V));V;zeros(1,length(V))];
% otherV = [zeros(1, length(otherV));otherV;zeros(1,length(otherV))];
% for i=1:length(V)
%     sin(2*pi*xcors)' -sin(2*pi*xcors)' 
%     [0; resistance(1:end-1)'/max(resistance); 0]
%     plot(xcors,[V(:,i) otherV(:,i)])
%     xlabel(strcat(num2str(eigvals(i)),'____',num2str(othereigvals(i))))
%     pause()
%     clf
% end



% plot(xcors(1:end),[0;V(:,1);0])

% 
% plot(xcors(1:end),[0;V(:,indices(3));0])


%eigenvalue counting fnc
%counting_graph(eigvals);
%xlabel("m=4 p=0.4 q=0.6")

%log eigenvalue plot
%plot(log(eigvals),zeros(length(eigvals),1),'o')
%xlabel("m=5 p=0.9 q=0.1")

% Weyl Plot
% f = @(x) countingfunction(eigvals,x);
% plotpoints = arrayfun(f,eigvals);
% p = polyfit(log(eigvals),log(plotpoints),1);
% alpha = p(1);
% otherplotpoints = arrayfun(f,othereigvals);
% [yval, indices] = sort(log(plotpoints'./(eigvals').^alpha));
% [otheyval, indices] = sort(log(otherplotpoints'./(othereigvals').^alpha));
% xval = log(eigvals');
% othexval = log(othereigvals');
% plot(log(eigvals'),log(plotpoints'./(eigvals').^alpha)); hold on;
% plot(log(othereigvals'), log(otherplotpoints'./(othereigvals').^alpha))
% xlabel("Weyl Plot m=5 alpha=0.4593")
 
% plot(linspace(0,1,4^m)', log([measure'./max(measure) resistance'./max(resistance)]))

% syms y(x)
% Dy = diff(y);
% ode = diff(y,x,2) == -eigvals(1) *y;
% cond1 = y(0) == 0;
% cond2 = y(1) == 0;
% conds = [cond1 cond2];
% ySol(x) = dsolve(ode, conds);
% ySol = simplify(ySol)

ode = @diff(x,y,2) + eigvals(1)*y;
options2 = odeset(options1,'NonNegative',1);
[x1,y1] = ode45(ode,[0 1],0,options2);
plot(x0,y0,'ro',x1,y1,'k*');


















