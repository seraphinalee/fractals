
rs = linspace(0.1,2,6);
data = zeros(length(rs),1);
for j =1:length(rs)
    r = rs(j);
    m=1;
    [mu0, mu1, r0, r1] = params(r);
    %search = 4;



    bans = forb(r)/(mu0*r0)^(m+1)*3/2;






    [smalllaplacian,smallplotting_points,smallpoints] = laplaciangen(m,mu0, r0, r1,0);
    [unique_eigvals, smalleigvals, V] = fullspectra(smalllaplacian);
    m=m+1;
    [laplacian,plotting_points,points] = laplaciangen(m,mu0, r0, r1,0);
    [unique_eigvals, eigvals, V] = fullspectra(laplacian);
    test = [];
    for i=1:length(smalleigvals)
    %for i=1:
        test= [test lambdamap(abs(smalleigvals(i)),r,m)];
    end
    %test = sort(test);

    test = align([[sort(test) zeros(1,length(eigvals)-length(test))];eigvals]');
    test = [test test(:,2)*(mu0*r0)^m/3*2];

    missing = [];

    for i=1:length(test)
        if test(i,1)==0
            missing = [missing;test(i,:)];
        end
    end
    for i=1:length(missing)
        if all(abs(bans-missing(i,2))>(10^-3)*missing(i,2)) && abs(missing(i,3)-6)>10^-3
           bans = [bans missing(i,2)];
           data(j) = missing(i,3);
        end
    end
end

data2 = zeros(length(rs),1);
for i=1:length(rs)
    r = rs(i);
    temp1 = (2*(7+14*r+19*r^2))/power(10-48*r-264*r^2-376*r^3-174*r^4+24*r^5+28*r^6+3*sqrt(3)*sqrt(-(1+r)^6*(9+134*r+75*r^2+148*r^3+723*r^4+686*r^5+225*r^6)),1/3);
    temp2 = power(10-48*r-264*r^2-376*r^3-174*r^4+24*r^5+28*r^6+3*sqrt(3)*sqrt(-(1+r)^6*(9+134*r+75*r^2+148*r^3+723*r^4+686*r^5+225*r^6)),1/3)/(1+r)^2;
    data2(i) = real(1/6*(20+temp1+2*temp2));
end


plot(rs',[data data2])
    






