function EvaluateDrivers(LabData)

global Body Jnt

Nframes=size(LabData.Coordinates,1);

Time = 0:1/LabData.Frequency : (Nframes -1)/ LabData.Frequency;

for i=1:Jnt.NDriver
    
    Dof = zeros(Nframes,1); %coordinates corresponding to the degrees of freedom of each driver
    
    for j=1:Nframes
        
        if (Jnt.Driver(i).type==2)
            Bodyi=Jnt.Driver(i).i; %trunk
            
            if (Jnt.Driver(i).ctype==1)
                Dof(j)=Body(Bodyi).r(j,1);
            elseif (Jnt.Driver(i).ctype==2)
                Dof(j)=Body(Bodyi).r(j,2);
            else
                Dof(j)=Body(Bodyi).theta(j);
            end
        elseif (Jnt.Driver(i).type==1)
            Bodyi = Jnt.Driver(i).i;
            Bodyj = Jnt.Driver(i).j;
            
            Dof(j)=Body(Bodyj).theta(j)-Body(Bodyi).theta(j);
        end
    end
    
    Jnt.Driver(i).Data=[Time',Dof];
%     figure()
%     plot(Jnt.Driver(i).Data(:,1),Jnt.Driver(i).Data(:,2));
    [a,b,c]= MySpline(Jnt.Driver(i).Data(:,1),unwrap(Jnt.Driver(i).Data(:,2)));     % cubic spline in time of positions, first derivative and second derivative with respect to time
    Jnt.Driver(i).q=a;
    Jnt.Driver(i).qd=b;
    Jnt.Driver(i).qdd=c;
end
end