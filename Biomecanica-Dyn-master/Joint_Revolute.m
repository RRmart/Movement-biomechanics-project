%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Function to add the Revolute kinematic joint information %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Phi,Jac] = Joint_Revolute(Phi,Jac,k)
%
% .. Acess global memory
%
global Body Jnt Nline
%
%.. update the line numbers for pointer
i1 = Nline;                                                                 
i2 = i1 +1;
% .. Initialize variables
i = Jnt.Revolute(k).i;
j = Jnt.Revolute(k).j;

% .. Assemble Position Constraint equations
%
Phi(i1:i2,1)=(Body(i).r(1,:)'+Body(i).A*(-Jnt.Revolute(k).spPi)'...
    -(Body(j).r(1,:)'+Body(j).A*(-Jnt.Revolute(k).spPj)'));

% .. Assemble the Jacobian matrix                                                       % note:Jacobian Matrix for the Revolute Joint is the derivative of Phi with respect to q: for more notes see lecture 15.10.2020 
j1 =  3*(i-1)+1;
j2 = j1 +2;
j3 = 3*(j-1)+1;
j4 = j3+2;
Jac(i1:i2,j1:j2)=[eye(2),Body(i).B*(-Jnt.Revolute(k).spPi)'];
Jac(i1:i2,j3:j4)=[-eye(2),-Body(j).B*(-Jnt.Revolute(k).spPj)'];
% .. Update the constraint number
Nline = Nline+2;                                                            % because the revolute joint has 2 constraints: 1 for x and 1 for y
% .. Finish the revolute joint contribution
end