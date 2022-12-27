function [Gint,qdd] = DynamicLagrange(t,y)
% Function to evaluate vector yd
%
% .. acess global memory
global NBodies Body Jnt

alpha=10;
beta=10;
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
Gint=zeros(Ncoordinates-3,1);
for i=1:Jnt.NRevolute
    r=Jnt.Revolute(i).i;
    line1=3*r-2;
    i1=3*i-2;
    j1=2*i-1;
    Aux=-Jac(j1:j1+1,:)'*lambda(j1:j1+1);
    Gint(i1:i1+1)=Aux(line1:line1+1);
end

for i=1:Jnt.NDriver-3
    k=Jnt.NRevolute*2+i;
    r=Jnt.Driver(i).j;
    line2=3*r;
    Aux=-Jac(k,:)*lambda(k,:);
    Gint(3*i)=Aux(line2);
end
    
%
% Finish function FuncEval
end