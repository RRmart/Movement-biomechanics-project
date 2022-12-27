function ResultsData(GaitData,q,qd,qdd)

global Output Jnt NBodies Body

Nframes=size(GaitData.Coordinates,1);  
Output.Time = 0:1/GaitData.Frequency : (Nframes -1)/ GaitData.Frequency;

for i=1:NBodies
    for time=1:length(Output.Time)
        i1 = 3*(i-1)+1;
        i2 = i1+1;
        i3 = i2+1;
        Output.Body(i).r(time,:) = q(i1:i2,time)';
        Output.Body(i).theta(time) = q(i3,time);
        
        Output.Body(i).rd(time,:) = qd(i1:i2,time)';
        Output.Body(i).thetad(time) = qd(i3,time);
        
        Output.Body(i).rdd(time,:) = qdd(i1:i2,time)';
        Output.Body(i).thetadd(time) = qdd(i3,time);
        
        Output.Body(i).COM=Body(i).COM;
        Output.Body(i).Length=Body(i).Length;
    end

Output.Driver=Jnt.Driver;


Output.Revolute=Jnt.Revolute;

end

