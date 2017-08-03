f0 = @(x) 1/2*(x-[0.5,tan(pi/3)*2]) + [0.5,tan(pi/3)*2];
f1 = @(x) 1/2*(x-[1,0]) + [1,0];
f2 = @(x) 1/2*(x-[0,0]) ;


m = 6;
epsilon = 0.1;

tris = [2
    3
    0
    0.5
    1
    0
    tan(pi/3)*2
    0];
model = createpde();  
for i = 1:m
    newtris = zeros(8,3^(i));
    for j=1:3^(i-1)
        tri = tris(:,j);
        a0 = f0([tri(3),tri(6)]);
        a1 = f1([tri(3),tri(6)]);
        a2 = f2([tri(3),tri(6)]);
        b0 = f0([tri(4),tri(7)]);
        b1 = f1([tri(4),tri(7)]);
        b2 = f2([tri(4),tri(7)]);
        c0 = f0([tri(5),tri(8)]);
        c1 = f1([tri(5),tri(8)]);
        c2 = f2([tri(5),tri(8)]);
        newtris(:,3*j) = [2
                        3
                        a0(1)
                        b0(1)
                        c0(1)
                        a0(2)
                        b0(2)
                        c0(2)
                        ];
         newtris(:,3*j-1) = [2
                        3
                        a1(1)
                        b1(1)
                        c1(1)
                        a1(2)
                        b1(2)
                        c1(2)
                        ];
         newtris(:,3*j-2) = [2
                        3
                        a2(1)
                        b2(1)
                        c2(1)
                        a2(2)
                        b2(2)
                        c2(2)
                        ];
    end
    tris = newtris;
end
for i=1:3^(m)
   tri = tris(:,i);
   centerx = (tri(3,1)+tri(4,1)+tri(5,1))/3;
   centery = (tri(6,1)+tri(7,1)+tri(8,1))/3;
   tris(3:end,i) = [tri(3,1)+epsilon*(tri(3,1)-centerx);
                    tri(4,1)+epsilon*(tri(4,1)-centerx);
                    tri(5,1)+epsilon*(tri(5,1)-centerx);
                    tri(6,1)+epsilon*(tri(6,1)-centery);
                    tri(7,1)+epsilon*(tri(7,1)-centery);
                    tri(8,1)+epsilon*(tri(8,1)-centery);];
end



gd = tris;
num_str1 = '';
for i =1:3^(m)
    num_str1 = strcat(num_str1,num2str(i));
end

name_len = ceil(log10(3^(m)));
ns = repmat('0',1,4+name_len);
for i=1:3^(m)
    ns = [ns; 'tri' num2str(i) zeros(1,name_len-floor(log10(i)))];
end
ns = ns(2:end,:);
ns = ns';
sf = '';
for i=1:3^(m)
    sf = strcat(sf,'tri',num2str(i),'+');
end
sf = sf(1:end-1);
[dl,bt] = decsg(gd,sf,ns);
geometryFromEdges(model,dl);
%pdegplot(model,'EdgeLabels','on');
%ylim([0,1.1]);
axis equal;
applyBoundaryCondition(model,'Edge',[1,484,546,547,63,609],'u',0);
specifyCoefficients(model,'m',0,'d',1,'c',1,'a',0,'f',0);
r = [0,100];
generateMesh(model,'Hmax',0.02);
results = solvepdeeig(model,r);
l = results.Eigenvalues;
u = results.Eigenvectors;
for i=1:12
    pdeplot(model,'XYData',-u(:,i),'ZData',-u(:,i));
    pause()
    clf
end