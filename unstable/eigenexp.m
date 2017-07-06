f0 = @(x) 1/2*(x-[0.5,tan(60)*2]) + [0.5,tan(60)*2];
f1 = @(x) 1/2*(x-[1,0]) + [1,0];
f2 = @(x) 1/2*(x-[0,0]) ;

m = 4;
radii = 0.005;

tris = [2
    3
    0
    0.5
    1
    0
    tan(60)*2
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
core_circs = [[1;0.5;0;radii;0;0;0;0] [1;0.25;0.32;radii;0;0;0;0] [1;0.75;0.32;radii;0;0;0;0]];
circs = core_circs;
for i=1:m-1
    newcircs = zeros(8,(3^(i+2)-3)/2-(3^(i+1)-3)/2);
    for j=1:(3^(i+1)-3)/2
        circ = circs(:,j);
        f0p = f0(circ(2:3)');
        f1p = f1(circ(2:3)');
        f2p = f2(circ(2:3)');
        newcircs(:,3*j) = [1;f0p(1);f0p(2);radii;0;0;0;0];
        newcircs(:,3*j-1) = [1;f1p(1);f1p(2);radii;0;0;0;0];
        newcircs(:,3*j-2) = [1;f2p(1);f2p(2);radii;0;0;0;0];
    end
    circs = [core_circs newcircs];
end




gd = [tris circs];
num_str1 = '';
for i =1:3^(m)
    num_str1 = strcat(num_str1,num2str(i));
end
num_str2 = '';
for i =1:(3^(m+1)-3)/2
    num_str2 = strcat(num_str2,num2str(i));
end
name_len = ceil(log10(max([3^(m) (3^(m+1)-3)/2])));
ns = repmat('0',1,4+name_len);
for i=1:3^(m)
    ns = [ns; 'tri' num2str(i) zeros(1,name_len-floor(log10(i)))];
end
for i=1:(3^(m+1)-3)/2
    ns = [ns; 'circ' num2str(i) zeros(1,name_len-floor(log10(i))-1)];
end
ns = ns(2:end,:);
ns = ns';
sf = '';
for i=1:3^(m)
    sf = strcat(sf,'tri',num2str(i),'+');
end
for i=1:(3^(m+1)-3)/2
    sf = strcat(sf,'circ',num2str(i),'+');
end
sf = sf(1:end-1);
[dl,bt] = decsg(gd,sf,ns);
geometryFromEdges(model,dl);
pdegplot(model,'EdgeLabels','on');
%ylim([0,1.1]);
axis equal;
applyBoundaryCondition(model,'Edge',[1,2,3],'u',0);
specifyCoefficients(model,'m',0,'d',1,'c',1,'a',0,'f',0);
r = [0,100];
generateMesh(model,'Hmax',0.02);
results = solvepdeeig(model,r);
l = results.Eigenvalues;
u = results.Eigenvectors;
pdeplot(model,'XYData',-u(:,2),'ZData',-u(:,2));