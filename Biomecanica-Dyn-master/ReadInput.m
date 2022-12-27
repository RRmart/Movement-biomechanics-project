% Modifications of the ReadInputFunction
%(Based on Equivalent function for kinematics)
function ReadInput()
%
%.. acess global memory
global Body 
global
%.. Read the input filename
%ESTA PARTE IR BUSCAR AO NOSSO CODIGO: PELO MENOS ATÉ A PARTE DO NPoint

Frc.NSpringDamper = H(1,7);
Frc.NGroundForce=H(1,8);
% ..Store the data for rigid bodies information
for i=1:NBodies
    line=line+1;
    Body(i).r=H(line,1:2)';
    Body(i).theta=H(line,3);
    Body(i).rd=H(line,4:5)';
    Body(i).thetad=H(line,6);
    Body(i).mass=H(line,7);
    Body(i).inertia=H(line,8);
end
%.. Store data for the force of Spring Damper
for K=1:Frc.NSpringDamper
    line=line+1;
    Frc.SpringDamper(k).i=H(line,1);
    Frc.SpringDamper(k).j=H(line,2);
    Frc.SpringDamper(k).spPi=H(line,3:4)';
    Frc.SpringDamper(k).spPi=H(line,5:6)';
    Frc.SpringDamper(k).k=H(line,7);
    Frc.SpringDamper(k).l0=H(line,8);
    Frc.SpringDamper(k).b=H(line,9);
    Frc.SpringDamper(k).a=H(line,10);
end
end

    
