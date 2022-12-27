function [qdd] = AccelerationAnalysis(qd,time,Jac)                    
% .. global variables   
global NBodies Jnt Body
%
Ncoordinates=3*NBodies;
gamma=zeros(Ncoordinates,1);

%gamma was created with order Revolute+Driver
for i=(1:Jnt.NRevolute)
    i1 = 3*(i-1)+1;
    thetadi = qd(3*(Jnt.Revolute(i).i));
    thetadj = qd(3*(Jnt.Revolute(i).j));
    gamma(i1:i1+1,1)=Body(i).A*(-Jnt.Revolute(i).spPi)'*thetadi^2- Body(i).A*(-Jnt.Revolute(i).spPj)'*thetadj^2;
end

for i=(1:Jnt.NDriver)
    gamma(i+Ncoordinates-Jnt.NDriver,1)=ppval(Jnt.Driver(i).qdd,Jnt.Driver(i).Data(time,1));
end

%
%
% solve the system of equations to get velocities
%
qdd = Jac\gamma;
%
% ... finish the funtion for acceleration analysis
%
end