function [Phi,Jac] = Joint_Driver(Phi,Jac,k,time)       % Mais notas na aula 20.10
%
% .. Acess global memory
%
global Body Jnt Nline
%
%.. update the line numbers for pointer
i1 = Nline;                                                              
% .. Initialize variables
i = Jnt.Driver(k).i;
j = Jnt.Driver(k).j;   
type = Jnt.Driver(k).type;
ctype = Jnt.Driver(k).ctype;

% .. Assemble Position Constraint equations
%
if type ==1
    Phi(i1,1) = (Body(j).theta(time)-Body(i).theta(time))-Jnt.Driver(k).Data(time,2);            % Information for uniformly accelerated system
    Jac(i1,3*i)=-1;
    Jac(i1,3*j)=1;
else
    if ctype==1
        Phi(i1,1)= Body(i).r(time,1)-(Jnt.Driver(k).Data(time,2));
        Jac(i1,3*i-2)=1;
    elseif ctype==2
        Phi(i1,1)= Body(i).r(time,2)-(Jnt.Driver(k).Data(time,2));
        Jac(i1,3*i-1)=1;
    else
        Phi(i1,1)= Body(i).theta(time)-(Jnt.Driver(k).Data(time,2));
        Jac(i1,3*i)=1;
    end
end
% .. Update the constraint number
Nline = Nline+1;                                                            % because the simple ground joint has 1 constraint
% .. Finish the revolute joint contribution
end