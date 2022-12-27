function [Phi,Jac,miu,gamma] = FunctEval(q,qd,t)                         % new positions and velocities every new time step
%
% ... global variables
%
global NBodies Body Jnt Nline                                              
% ... Transfer data to local variables

Ncoordinates=3*NBodies;

%
Nline = 1;

%
% .. Populate vectors and matrix with constraints
Phi = zeros(Ncoordinates,1);
Jac = zeros(Ncoordinates,Ncoordinates); 
miu=zeros(Ncoordinates,1);
gamma=zeros(Ncoordinates,1);
%
%.. Contribution by Revolute joints
for k=1:Jnt.NRevolute
    [Phi,Jac] = Joint_Revolute(Phi,Jac,k);
    i1 = 3*(k-1)+1;
    thetadi = Body(Jnt.Revolute(k).i).thetad(1);
    thetadj = Body(Jnt.Revolute(k).j).thetad(1);
    gamma(i1:i1+1,1)=Body(k).A*(-Jnt.Revolute(k).spPi)'*thetadi^2- Body(k).A*(-Jnt.Revolute(k).spPj)'*thetadj^2;
end                                                                   
%.. Contribution by Drivint constraints
for k=1:Jnt.NDriver
    [Phi,Jac] = Joint_Driver(Phi,Jac,k,t);
    miu(k+Ncoordinates - Jnt.NDriver,1)=ppval(Jnt.Driver(k).qd,t);
    gamma(k+Ncoordinates-Jnt.NDriver,1)=ppval(Jnt.Driver(k).qdd,t);
end
%
%..  finalize function to add constraints
% end


