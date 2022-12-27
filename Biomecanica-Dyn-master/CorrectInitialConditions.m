function [q,qd,Jac] = CorrectInitialConditions(tstart)
% Function to correct Initial conditions for the analysis
global NBodies Body
%
% .. Setup the initial conditions for kinematic Analysis
%
q0=zeros(NBodies,1);
for i=1:NBodies
    q0(3*i-2,1) = Body(i).r(1,1);
    q0(3*i-1,1)=Body(i).r(1,2);
    q0(3*i,1)= Body(i).theta(1);
end

% .. Perform the positions analysis
[q,Jac,~] = PositionAnalysis(q0,tstart);
%
% .. Perform the velocity analysis
qd = VelocityAnalysis(tstart,Jac);
%
% .. Finish function CorrectInitialConditions

end