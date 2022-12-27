function [Phi,Jac] = FunctEval(q,time,Phi,Jac)                         % new positions and velocities every new time step
%
% ... global variables
%
global NBodies Body Jnt Nline;                                              
% ... Transfer data to local variables

for i=1:NBodies
    i1 = 3*(i-1)+1;
    i2 = i1+1;
    i3 = i2+1;
    % .. Transfer position data to local storage
        Body(i).r(time,:) = q(i1:i2,1)'; 
        Body(i).theta(time) = q(i3,1);    
        %
% .. Evaluate the tranformation matrixes
cost = cos(Body(i).theta(time));
sint = sin(Body(i).theta(time));
Body(i).A = [cost -sint; sint cost];
Body(i).B =[-sint -cost; cost -sint];

end

%
Nline = 1;

%
% .. Populate vectors and matrix with constraints
%
%.. Contribution by Revolute joints
for k=1:Jnt.NRevolute
    [Phi,Jac] = Joint_Revolute(Phi,Jac,k,time);
end                                                                   
%.. Contribution by Drivint constraints
for k=1:Jnt.NDriver
    [Phi,Jac] = Joint_Driver(Phi,Jac,k,time);
end
%
%..  finalize function to add constraints
% end


