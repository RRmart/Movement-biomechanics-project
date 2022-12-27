function PlotResults

global Output TotalBodyMass

Time = Output.Time;
t=(Time./Time(end)).*100;

%% joint moment plots

lista={'right hip','right knee','right ankle',};
numJnt=[10,11,12];

M1=-Output.Revolute(numJnt(1)).M1./TotalBodyMass;
figure()
     set(gcf,'position',[10,10,550,200])
    plot(t,M1);
    hold on
    line([t(1),t(end)],[0,0],'Color','k','LineStyle','--')
    axis([0 100 -1 1])
     xlabel('% of Stride')
     ylabel('Joint Moment (Nm/kg)')
    title(strcat('Moment of the',{' '}, lista(1),' joint over time'))
    hold off
    
    
M2=-Output.Revolute(numJnt(3)).M1./TotalBodyMass;
     figure()
     set(gcf,'position',[10,10,550,200])
    plot(t,M2);
    hold on
    line([t(1),t(end)],[0,0],'Color','k','LineStyle','--')
    axis([0 100 -0.2 2])
     xlabel('% of Stride')
     ylabel('Joint Moment (Nm/kg)')
    title(strcat('Moment of the',{' '}, lista(3),' joint over time'))
    hold off
    
 M3=Output.Revolute(numJnt(2)).M1./TotalBodyMass;
     figure()
     set(gcf,'position',[10,10,550,200])
    plot(t,M3);
    hold on
    line([t(1),t(end)],[0,0],'Color','k','LineStyle','--')
    axis([0 100 -1 1])
     xlabel('% of Stride')
     ylabel('Joint Moment (Nm/kg)')
    title(strcat('Moment of the',{' '}, lista(2),' joint over time'))
    hold off


M=M1+M2+M3;
    figure()
     set(gcf,'position',[10,10,550,200])
    plot(t,M);
    hold on
    line([t(1),t(end)],[0,0],'Color','k','LineStyle','--')
    axis([0 100 -0.5 1])
     xlabel('% of Stride')
     ylabel('Support Moment (Nm/kg)')
     title('Support Moment over time')
     hold off
     
    
%% joint Force plots

lista={'right hip','right knee','right ankle'};
numJnt=[10,11,12];
for i=(1:length(numJnt))
    Fx=Output.Revolute(numJnt(i)).Fx1./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,300])
    plot(t,Fx);
     xlabel('% of Stride')
     ylabel('Force (N/kg)')
    title(strcat('Fx of the',{' '}, lista(i),' joint over time'))

end

lista={'right hip','right knee','right ankle'};
numJnt=[10,11,12];
for i=(1:length(numJnt))
    Fz=Output.Revolute(numJnt(i)).Fz1./TotalBodyMass;
    figure()
     set(gcf,'position',[10,10,550,300])
    plot(t,Fz);
     xlabel('% of Stride')
     ylabel('Force (N/kg)')
    title(strcat('Fz of the',{' '}, lista(i),' joint over time'))

end

%% Joint Power plots

lista={'right hip','right knee','right ankle'};
numJnt=[10,11,12];
    M=-Output.Revolute(numJnt(1)).M1;
    thetad=Output.Revolute(numJnt(1)).thetad;
    P=(M.*thetad')./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,200])
    plot(t,P);
    hold on
    line([t(1),t(end)],[0,0],'Color','k','LineStyle','--')
    axis([0 100 -1 1.5])
     xlabel('% of Stride')
     ylabel('Joint Power (W/kg)')
    title(strcat('Joint Power of the',{' '}, lista(1),' joint over time'))
    hold off
    
    M=Output.Revolute(numJnt(2)).M1;
    thetad=-Output.Revolute(numJnt(2)).thetad;
    P=(M.*thetad')./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,200])
    plot(t,P);
    hold on
    line([t(1),t(end)],[0,0],'Color','k','LineStyle','--')
    axis([0 100 -2 1])
     xlabel('% of Stride')
     ylabel('Joint Power (W/kg)')
    title(strcat('Joint Power of the',{' '}, lista(2),' joint over time'))
    hold off
    
    M=-Output.Revolute(numJnt(3)).M1;
    thetad=Output.Revolute(numJnt(3)).thetad;
    P=(M.*thetad')./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,200])
    plot(t,P);
    hold on
    line([t(1),t(end)],[0,0],'Color','k','LineStyle','--')
    axis([0 100 -1 4])
     xlabel('% of Stride')
     ylabel('Joint Power (W/kg)')
    title(strcat('Joint Power of the',{' '}, lista(3),' joint over time'))
    hold off
    


    
    

