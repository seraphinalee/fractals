for p=linspace(0.49,0.01,100)
    q=1-p;
    cutoff = 0;
    m=2;
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

    pointmass = (measure(1:end-1)+measure(2:end))/2;




    [xcors,laplacian] = intervallapgen(m,p,1-p,0); %m,p,q,cutoff
    [~,eigvals,V] = fullspectra(laplacian);
    otherlaplacian = laplacian;
    p=1-p;
    [xcors,laplacian] = intervallapgen(m,p,1-p,0); %m,p,q,cutoff
    [~,othereigvals,otherV] = fullspectra(laplacian);
    V = [zeros(1, length(V));V;zeros(1,length(V))];
    otherV = [zeros(1, length(otherV));otherV;zeros(1,length(otherV))];
    
    
    index = 10;
    subplot(2,1,1)
    plot(xcors,[V(2,index)/abs(V(2,index))*V(:,index) otherV(2,index)/abs(otherV(2,index))*otherV(:,index) sin(index*pi*xcors)'])
    ylim([-1 1])
    subplot(2,1,2)
    plot(xcors,[0;measure(2:end)'./measure(1:end-1)';0])
    
    %subplot(3,1,2)
    %bar(xcors(2:end),resistance(1:end)')
    %subplot(3,1,3)
    %bar(xcors(2:end),transform(measure(1:end))')
    xlabel(strcat(num2str(eigvals(i)),'____',num2str(othereigvals(i))))
    pause()
    clf
end
   



% plot(xcors(1:end),[0;V(:,1);0])


%plot(xcors(1:end),[0;V(:,indices(3));0])


%eigenvalue counting fnc
%counting_graph(eigvals);
%xlabel("m=4 p=0.4 q=0.6")

%log eigenvalue plot
%plot(log(eigvals),zeros(length(eigvals),1),'o')
%xlabel("m=5 p=0.9 q=0.1")

% % Weyl Plot
% f = @(x) countingfunction(eigvals,x);
% plotpoints = arrayfun(f,eigvals);
% p = polyfit(log(eigvals),log(plotpoints),1);
% alpha = p(1);
% plot(log(eigvals'),log(plotpoints'./(eigvals').^alpha))
% xlabel("m=5 p=0.1 q=0.9")

%plot(linspace(0,1,4^m)', log([measure'./max(measure) resistance'./max(resistance)]))

