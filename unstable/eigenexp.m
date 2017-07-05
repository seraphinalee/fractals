f0 = @(x) 1/2*(x-[0.5,tan(60)*2]) + [0.5,tan(60)*2];
f1 = @(x) 1/2*(x-[1,0]) + [1,0];
f2 = @(x) 1/2*(x-[0,0]) ;

m = 1;

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
        tri = tris(:,j)
        a0 = f0([tri(3),tri(6)]);
        a1 = f1([tri(3),tri(6)]);
        a2 = f2([tri(3),tri(6)]);
        b0 = f0([tri(4),tri(7)]);
        b1 = f1([tri(4),tri(7)]);
        b2 = f2([tri(4),tri(7)]);
        c0 = f0([tri(5),tri(8)]);
        c1 = f1([tri(5),tri(8)]);
        c2 = f2([tri(5),tri(8)]);
        newtris(:,j) = [2
                        3
                        a0(1)
                        b0(1)
                        c0(1)
                        a0(2)
                        b0(2)
                        c0(2)
                        ];
         newtris(:,j+1) = [2
                        3
                        a1(1)
                        b1(1)
                        c1(1)
                        a1(2)
                        b1(2)
                        c1(2)1
                        ];
         newtris(:,j+2) = [2
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
tris = [tris [1;0.5;0;0.05;0;0;0;0] [1;0.25;0.32;0.05;0;0;0;0] [1;0.75;0.32;0.05;0;0;0;0]]
gd = tris
ns = char('tri1','tri2','tri3','circ1','circ2','circ3')
ns = ns'
sf = 'tri1+tri2+tri3+circ1+circ2+circ3'
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
pdeplot(model,'XYData',u(:,2));