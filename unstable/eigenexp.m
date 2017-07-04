model = createpde(3);
t1 = [2
    3
    0
    0.5
    1
    0
    tan(60)*0.5
    0];
gd = t1;
ns = char('tri1');
ns = ns';
sf = 'tri1';
[dl,bt] = decsg(gd,sf,ns);
geometryFromEdges(model,dl);
pdegplot(model,'EdgeLabels','on')
applyBoundaryCondition(model,'Edge',[1,2,3],'u',2);
%E = 200e9; % elastic modulus of steel in Pascals
%nu = 0.3; % Poisson's ratio
%specifyCoefficients(model,'m',0,...
%                          'd',1,...
%                          'c',elasticityC3D(E,nu),...
%                          'a',0,...
%                          'f',[0;0;0]); % Assume all body forces are zero
%evr = [-Inf,1e7];
%generateMesh(model);
%results = solvepdeeig(model,evr);
%length(results.Eigenvalues);
%V = results.Eigenvectors;
%subplot(2,2,1)
%pdeplot3D(model,'ColorMapData',V(:,1,1))
%title('x Deflection, Mode 1')
%subplot(2,2,2)
%pdeplot3D(model,'ColorMapData',V(:,2,1))
%title('y Deflection, Mode 1')
%subplot(2,2,3)
%pdeplot3D(model,'ColorMapData',V(:,3,1))
%title('z Deflection, Mode 1')


