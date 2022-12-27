function [q,qd,qdd,lambda]= ReportResults(t,y)

% Define global variables 
global NBodies NRevolute Body Jnt

% Number of steps
NSteps = length(t);

% Allocates memory for the data
q=zeros(3*NBodies,NSteps);
qd=zeros(3*NBodies,NSteps);
qdd=zeros(3*NBodies,NSteps);
lambda=zeros(3*NBodies,NSteps);
JointTorques=zeros(3,NSteps);

% .. For each time step computes qdd and lambda
for i=1:NSteps
    
    % Update body information
    Body = y2q(y(i,:)', Body, NBodies);
    
    % NÃO ACABEI !!!!!!!!!!!!!!!!!

    
    