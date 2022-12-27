% Function to add Contact forces
function [g] = ForceContact(g,t)
% note that the case of application to the analysis of human motion for gait
% the contact forces may (will) change in time not only in terms of
% magnitude and direction but also on their points of application
%   sPi and f are time dependent function, obtained with data acquired at
%   the laboratory
%
%..Acess global memory
global NFplates FPlate Body Jnt
% ..For each contact force(ground reaction force)

for k=1:NFplates 
    x=ppval(FPlate(k).copx,t);
    z=ppval(FPlate(k).copz,t);
    i=FPlate(k).i;
    j=FPlate(k).j;
    r=Body(i).PtsAdj(2);
    Forcex = ppval(FPlate(k).mx,t);
    Forcez = ppval(FPlate(k).mz,t);
    f=[Forcex;Forcez];
    %calculate the body in which the force is applied 
    JointPosition=(Body(i).r(1,:)'+Body(i).A*(-Jnt.Revolute(i).spPi)')'*[1;0]; %x component of joint foot-toe position
    
    if (JointPosition-x)>0 %force applied on the foot
       sPi = ([x,z]-Body(i).r(1,:))';
       i1=3*i-2;
       i2=i1+2;
        
    else %force applied on the toe
       sPi = ([x,0]-Body(j).r(1,:))';
       i1=3*j-2;
       i2=i1+2;
    end
%     i1=3*i-2;
%     i2=i1+2;
    [g(i1:i2,1)]=ApplyForce(g(i1:i2,1),f,sPi);
end
%
%..Finish the contact force function
end
