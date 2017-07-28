function [ output ] = customclean( input,ban,tol)
%Utility function, removes everything from input within tol*values of a
%number n the ban list. Used for protecting decimation from forbidden
%eigenvalues

output = [];
for i=1:length(input)
    if sum(abs(input(i)-ban)<abs(input(i))*tol)==0
        output = [output input(i)]; 
    end
end

end

