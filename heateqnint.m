
p=0.6;
q=1-p;
cutoff = 0;
m=5;


[xcors,laplacian,measure] = intervalneumgen(m,p,q,0); %m,p,q,cutoff
[~,eigvals,V] = fullspectra(laplacian);

for i=1:length(eigvals)
    V(:,i) = V(:,i)./sqrt(dot(V(:,i).^2,measure'));
end

%offset = round(length(xcors)/2);
offset = 512;
num = 1;
val = 100;
bckgrd = 10^-3;
f = [bckgrd*ones(1,offset) val*ones(1,num) bckgrd*ones(1,length(xcors)-2-offset-num)];


ts = linspace(10^-4,10^-2,100);



efuncs = permute(V,[3,1,2]);
efuncref = repmat(permute(dot(V,repmat(f'.*measure',1,length(eigvals))),[1 3 2]),1,length(xcors)-2,1);
efuncs = efuncs.*efuncref;
efuncs = repmat(efuncs,length(ts),1,1);
evals = repmat(permute(eigvals,[1 3 2]),length(ts),1,1);
%activate this line for heat eqn
evals = repmat(exp(-evals.*repmat(ts',1,1,length(eigvals))),1,length(xcors)-2,1);
%and this one for wave eqn
%evals = repmat(sin(sqrt(evals).*repmat(ts',1,1,length(eigvals)))./sqrt(evals),1,length(xcors),1);
u = efuncs.*evals;
u = sum(u,3);




%surf(xcors,ts,squeeze(u),'LineStyle','none')


%v = VideoWriter('heat09.avi');
%open(v);

F(length(ts)) = struct('cdata',[],'colormap',[]);
for j = 1:length(ts)
   plot(u(j,:))
   ylim([-1 1])
   F(j) = getframe;
   %frame = getframe(gcf);
   %writeVideo(v,frame);
end
movie(F,10,60)
%close(v);




