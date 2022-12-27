function [yd] = DynamicFuncEval(t,y)
% Function to evaluate vector yd
%
% .. acess global memory
global NBodies Body 

alpha=15;
beta=15;
Ncoordinates=3*NBodies;
% 
%.. Transfer position and velocity to Body
[Body]=yzq(y,Body,NBodies);                                                 %Nota: lembrar qu o vetor y é um vetor coluna com o q e o qd
%
q=y(1:Ncoordinates,1);
qd=y(Ncoordinates+1:end,1);
%.. Build the mass matrix
[M] = BuildMassMatrix(Body,NBodies);
% .. Build the Jacobian matrix and all kinematic vectors
[Phi,Jac,miu,gamma] = FunctEval(q,qd,t); % we apply funcEval to q and qd
%
%..Build the force vector
[g]=BuildForceVector(t);
%
%.. Build the leading matrix and r.h.s. vector of the equations
Null=zeros(Ncoordinates,Ncoordinates);
Mat = [M Jac';...
    Jac Null];

b = [g;...
    gamma-2*alpha*(Jac*qd-miu)-beta^2*Phi];
% .. Solve the system of equations of motion
X = Mat\b; % Rember that X is a column vector that contains qdd and lambda
%
% .. Form the acceleration vector
qdd = X(1:Ncoordinates,1);
lambda=X(Ncoordinates+1:end);
%
%.. Form the ydot vector
yd = [qd;qdd];
%
% Finish function FuncEval
end

