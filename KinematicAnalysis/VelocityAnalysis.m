function [qd] = VelocityAnalysis(time,Jac)
% .. global variables   
% 
global NBodies Jnt
%
% ... Form the r.h.o. of the velocity equations(miu)
Ncoordinates=3*NBodies;
miu=zeros(Ncoordinates,1);

for i=(1:Jnt.NDriver)
    miu(i+Ncoordinates - Jnt.NDriver,1)=ppval(Jnt.Driver(i).qd,Jnt.Driver(i).Data(time,1));
% .. Solve the system of equations to get the velocities
qd = Jac\miu;
% ... finish the function for the velocity analysis
end



