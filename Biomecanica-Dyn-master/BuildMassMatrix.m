function [M] = BuildMassMatrix(Body,NBodies)
% function to build the Mass Matrix
% What does my matrix have?
% M = [ m1I
%          J1
%            M2I
%               J2 ....
%                      ]
%
% .. Create auxiliary vector with matrix diagonal
Ncoordinates=3*NBodies;
aux = zeros(Ncoordinates,1);
for i=1:NBodies
    i1=3*i-2;
    i2=i1+2;
    aux(i1:i2,:)=[Body(i).mass; Body(i).mass; Body(i).inertia];
end

M=diag(aux);
%
%.. Finish build Mass matrix 
    
end