function ResultsData(y,Gint,qdd,Time)

global Output NBodies Body Jnt

Output.Time=Time;

 Ncoordinates=3*NBodies;
for i=1:NBodies
    i1 = 3*i-2;
    i2=i1+1;
    i3= i2+1;
    i4 = i1+Ncoordinates;
    i5 = i4+1;
    i6 = i5+1;
    Output.Body(i).r = y(:,i1:i2); 
    Output.Body(i).theta = y(:,i3);    
    Output.Body(i).rd =y(:,i4:i5);
    Output.Body(i).thetad = y(:,i6);
    Output.Body(i).rdd =qdd(i1:i2,:);
    Output.Body(i).thetadd = qdd(i3,:);
    Output.Body(i).COM = Body(i).COM;
    Output.Body(i).Length = Body(i).Length;
    
end
Output.NRevolute=Jnt.NRevolute;
for i=1:Jnt.NRevolute
    i1=3*i-2;
    i2=i1+1;
    i3=i1+2;
    Output.Revolute(i).Fx1=Gint(i1,:);
    Output.Revolute(i).Fz1=Gint(i2,:);
    Output.Revolute(i).M1=Gint(i3,:);
    Output.Revolute(i).thetad=Output.Body(Jnt.Revolute(i).i).thetad(:)-Output.Body(Jnt.Revolute(i).j).thetad(:);
end

end

