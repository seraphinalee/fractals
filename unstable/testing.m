p=0.4;
q=1-p;
cutoff = (p*q/4)^(1/4);
disp(cutoff);
clf
m=1;

[xcors1,laplacian1, pm, meas2, res3] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
disp('1, ')
disp(length(xcors1))
plot(xcors1(1:(length(xcors1)-1)/2), -0.5*ones((length(xcors1)-1)/2), 'o')
hold on

m=2;

[xcors1,laplacian1, pm, meas, res] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals1,V1] = fullspectra(laplacian1);
disp('2, ')
disp(length(xcors1))


plot(xcors1(1:(length(xcors1)-1)/2), zeros((length(xcors1)-1)/2), 'o')


m=3;

[xcors,laplacian4] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals,V] = fullspectra(laplacian4);
disp('3, ')
disp(length(xcors))

plot(xcors(1:(length(xcors)-1)/2), 0.5*ones((length(xcors)-1)/2), 'o')


m=4;

[xcors2,laplacian1] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals2,V1] = fullspectra(laplacian1);

plot(xcors2(1:(length(xcors2)-1)/2), ones((length(xcors2)-1)/2), 'o')
%ylim([0 3])
disp('4, ')
disp(length(xcors2))
m=5;

[xcors3,laplacian1, meas1, meas] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
[x,eigvals3,V1] = fullspectra(laplacian1);

plot(xcors3(1:(length(xcors3)-1)/2), 1.5*ones((length(xcors3)-1)/2), 'o')
disp('5, ')
disp(length(xcors3))

m=6;

[xcors4,laplacian1] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
%[x,eigvals4,V1] = fullspectra(laplacian1);

plot(xcors4(1:(length(xcors4)-1)/2), 2*ones((length(xcors4)-1)/2), 'o')
xlabel(num2str(p))
disp('6, ')
disp(length(xcors4))
% m=7;
% [xcors5,laplacian1] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
% %[x,eigvals5,V1] = fullspectra(laplacian1);
% disp('7, ')
% disp(length(xcors5))
% plot(xcors5(1:(length(xcors5)-1)/2), 2.5*ones((length(xcors5)-1)/2), 'o')
% 
% 
% 
% m=8;
% [xcors6,laplacian1] = intervallapgen(m,p,1-p,cutoff); %m,p,q,cutoff
% %[x,eigvals5,V1] = fullspectra(laplacian1);
% disp('7, ')
% disp(length(xcors5))
% plot(xcors6(1:(length(xcors6)-1)/2), 3*ones((length(xcors6)-1)/2), 'o')
