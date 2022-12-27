function PlotResultsSquat

global Output TotalBodyMass FPlate Body

Time = Output.Time;
Time1=Time(1:362);
Time2=Time(363:752);
Time3=Time(753:end);
t1=(Time1./(Time1(end)-Time1(1))).*100;
t2=((Time2-Time2(1))./(Time2(end)-Time2(1))).*100;
t3=((Time3-Time3(1))./(Time3(end)-Time3(1))).*100;


%% joint moment plots - Squat 2

lista={'right hip','right knee','right ankle',};
numJnt=[10,11,12];

M1=-Output.Revolute(numJnt(1)).M1(363:752)./TotalBodyMass;
figure()
     set(gcf,'position',[10,10,550,300])
    plot(t2,M1);
    hold on
   line([50,50],[-1,0],'Color','k','LineStyle','--');
    axis([0 100 -1 0])
     xlabel('% of Squat')
     ylabel('Joint Moment (Nm/kg)')
    title(strcat('Moment of the',{' '}, lista(1),' joint over time'))
    hold off
    
    
M2=-Output.Revolute(numJnt(3)).M1(363:752)./TotalBodyMass;
     figure()
     set(gcf,'position',[10,10,550,300])
    plot(t2,M2);
    hold on
    line([50,50],[-1,0],'Color','k','LineStyle','--');
    axis([0 100 -1 0])
     xlabel('% of Squat')
     ylabel('Joint Moment (Nm/kg)')
    title(strcat('Moment of the',{' '}, lista(3),' joint over time'))
    hold off
    
 M3=-Output.Revolute(numJnt(2)).M1(363:752)./TotalBodyMass;
     figure()
     set(gcf,'position',[10,10,550,300])
    plot(t2,M3);
    hold on
    line([50,50],[-0.35,0.8],'Color','k','LineStyle','--');
    axis([0 100 -0.35 0.8])
     xlabel('% of Squat')
     ylabel('Joint Moment (Nm/kg)')
    title(strcat('Moment of the',{' '}, lista(2),' joint over time'))
    hold off

%% joint moment plots - superposition

numJnt=[10,11,12];
M1_1=-Output.Revolute(numJnt(1)).M1(1:362)./TotalBodyMass;
M1_2=-Output.Revolute(numJnt(1)).M1(363:752)./TotalBodyMass;
M1_3=-Output.Revolute(numJnt(1)).M1(753:end)./TotalBodyMass;
figure()
     set(gcf,'position',[10,10,550,300])
    plot(t1,M1_1);
    hold on
    plot(t2,M1_2);
    plot(t3,M1_3);
    line([50,50],[-1,0],'Color','k','LineStyle','--');
    axis([0 100 -1 0])
     xlabel('% of Squat')
     ylabel('Joint Moment (Nm/kg)')
     legend('Squat 1', 'Squat 2', 'Squat 3')
    title('Moment of the hip joint over time');
    hold off
    
M2_1=-Output.Revolute(numJnt(2)).M1(1:362)./TotalBodyMass;
M2_2=-Output.Revolute(numJnt(2)).M1(363:752)./TotalBodyMass;
M2_3=-Output.Revolute(numJnt(2)).M1(753:end)./TotalBodyMass;
figure()
     set(gcf,'position',[10,10,550,300])
    plot(t1,M2_1);
    hold on
    plot(t2,M2_2);
    plot(t3,M2_3);
    line([50,50],[-0.35,0.8],'Color','k','LineStyle','--');
    axis([0 100 -0.35 0.8])
     xlabel('% of Squat')
     ylabel('Joint Moment (Nm/kg)')
     legend('Squat 1', 'Squat 2', 'Squat 3')
    title('Moment of the knee joint over time');
    hold off


M2_1=-Output.Revolute(numJnt(3)).M1(1:362)./TotalBodyMass;
M2_2=-Output.Revolute(numJnt(3)).M1(363:752)./TotalBodyMass;
M2_3=-Output.Revolute(numJnt(3)).M1(753:end)./TotalBodyMass;
figure()
     set(gcf,'position',[10,10,550,300])
    plot(t1,M2_1);
    hold on
    plot(t2,M2_2);
    plot(t3,M2_3);
    line([50,50],[-1,0],'Color','k','LineStyle','--');
    axis([0 100 -1 0])
     xlabel('% of Squat')
     ylabel('Joint Moment (Nm/kg)')
     legend('Squat 1', 'Squat 2', 'Squat 3')
    title('Moment of the ankle joint over time');
    hold off    
    
 %% COP displacement plot - superposition
 
 displacement1=ppval(Time1,FPlate(2).copx);
 displacement2=ppval(Time2,FPlate(2).copx);
 displacement3=ppval(Time3,FPlate(2).copx);
 
 % toe tip position
 r = Body(14).r(1,:)';
 theta = Body(14).theta(1);
 A = [cos(theta) -sin(theta); sin(theta) cos(theta)];
 P2 = r+A*[(1-Body(14).COM)*Body(14).Length;0];
 
 %approximated heel position
 P3=P2+[0.242,0];
 
 displ1=((displacement1-P2(1))./(P3(1)-P2(1))).*100;
 displ2=((displacement2-P2(1))./(P3(1)-P2(1))).*100;
 displ3=((displacement3-P2(1))./(P3(1)-P2(1))).*100;
 
 figure()
     set(gcf,'position',[10,10,550,300])
    plot(t1,displ1);
    hold on
    plot(t2,displ2);
    plot(t3,displ3);
    line([50,50],[0,100],'Color','k','LineStyle','--');
     axis([0 100 0 100])
     xlabel('% of Squat')
     ylabel('COP displacement (% of foot length)')
     legend('Squat 1', 'Squat 2', 'Squat 3')
    title('COP displacement for Plate 2 (right foot)');
     hold off 
 
%% COP displacement plot

displacement3=ppval(Time3,FPlate(2).copx);

% toe tip position
 r = Body(14).r(1,:)';
 theta = Body(14).theta(1);
 A = [cos(theta) -sin(theta); sin(theta) cos(theta)];
 P2 = r+A*[(1-Body(14).COM)*Body(14).Length;0];
 
 %approximated heel position
 P3=P2+[0.242,0];
 
 displ3=((displacement3-P2(1))./(P3(1)-P2(1))).*100;
 
 figure()
     set(gcf,'position',[10,10,550,300])
    plot(t3,displ3);
    line([50,50],[0,100],'Color','k','LineStyle','--');
     axis([0 100 0 100])
     xlabel('% of Squat')
     ylabel('COP displacement (% of foot length)')
    title('COP displacement for Plate 2 (right foot)');
    
%% joint Force plot - Squat 2
lista={'right hip','right knee','right ankle'};
numJnt=[10,11,12];
for i=(1:length(numJnt))
    Fx1_2=-Output.Revolute(numJnt(i)).Fx1(363:752)./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,300])
    plot(t2,Fx1_2);
    xlabel('% of Squat')
    ylabel('Force (N/kg)')
    title(strcat('Fx of the',{' '}, lista(i),' joint over time'))
    
    Fz1_2=-Output.Revolute(numJnt(i)).Fz1(363:752)./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,300])
    plot(t2,Fz1_2);
    xlabel('% of Squat')
    ylabel('Force (N/kg)')
    title(strcat('Fz of the',{' '}, lista(i),' joint over time'))

end

%% joint Force plots - superposition

% Fx
lista={'right hip','right knee','right ankle'};
numJnt=[10,11,12];
    Fx1_1=-Output.Revolute(numJnt(1)).Fx1(1:362)./TotalBodyMass;
    Fx1_2=-Output.Revolute(numJnt(1)).Fx1(363:752)./TotalBodyMass;
    Fx1_3=-Output.Revolute(numJnt(1)).Fx1(753:end)./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,300])
    plot(t1,Fx1_1);
    hold on
    plot(t2,Fx1_2);
    plot(t3,Fx1_3);
     xlabel('% of Squat')
     ylabel('Force (N/kg)')
     legend('Squat 1', 'Squat 2', 'Squat 3')
    title(strcat('Fx of the',{' '}, lista(1),' joint over time'))

Fx1_1=-Output.Revolute(numJnt(2)).Fx1(1:362)./TotalBodyMass;
    Fx1_2=-Output.Revolute(numJnt(2)).Fx1(363:752)./TotalBodyMass;
    Fx1_3=-Output.Revolute(numJnt(2)).Fx1(753:end)./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,300])
    plot(t1,Fx1_1);
    hold on
    plot(t2,Fx1_2);
    plot(t3,Fx1_3);
     xlabel('% of Squat')
     ylabel('Force (N/kg)')
     legend('Squat 1', 'Squat 2', 'Squat 3')
    title(strcat('Fx of the',{' '}, lista(2),' joint over time'))
    
    Fx1_1=-Output.Revolute(numJnt(3)).Fx1(1:362)./TotalBodyMass;
    Fx1_2=-Output.Revolute(numJnt(3)).Fx1(363:752)./TotalBodyMass;
    Fx1_3=-Output.Revolute(numJnt(3)).Fx1(753:end)./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,300])
    plot(t1,Fx1_1);
    hold on
    plot(t2,Fx1_2);
    plot(t3,Fx1_3);
     xlabel('% of Squat')
     ylabel('Force (N/kg)')
     legend('Squat 1', 'Squat 2', 'Squat 3')
    title(strcat('Fx of the',{' '}, lista(3),' joint over time'))
    
    
% Fz     
lista={'right hip','right knee','right ankle'};
numJnt=[10,11,12];

    Fz1_1=-Output.Revolute(numJnt(1)).Fz1(1:362)./TotalBodyMass;
    Fz1_2=-Output.Revolute(numJnt(1)).Fz1(363:752)./TotalBodyMass;
    Fz1_3=-Output.Revolute(numJnt(1)).Fz1(753:end)./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,300])
    plot(t1,Fz1_1);
    hold on
    plot(t2,Fz1_2);
    plot(t3,Fz1_3);
     xlabel('% of Squat')
     ylabel('Force (N/kg)')
     legend('Squat 1', 'Squat 2', 'Squat 3')
    title(strcat('Fz of the',{' '}, lista(1),' joint over time'))
    
    Fz1_1=-Output.Revolute(numJnt(2)).Fz1(1:362)./TotalBodyMass;
    Fz1_2=-Output.Revolute(numJnt(2)).Fz1(363:752)./TotalBodyMass;
    Fz1_3=-Output.Revolute(numJnt(2)).Fz1(753:end)./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,300])
    plot(t1,Fz1_1);
    hold on
    plot(t2,Fz1_2);
    plot(t3,Fz1_3);
     xlabel('% of Squat')
     ylabel('Force (N/kg)')
     legend('Squat 1', 'Squat 2', 'Squat 3')
    title(strcat('Fz of the',{' '}, lista(2),' joint over time'))
    
    Fz1_1=-Output.Revolute(numJnt(3)).Fz1(1:362)./TotalBodyMass;
    Fz1_2=-Output.Revolute(numJnt(3)).Fz1(363:752)./TotalBodyMass;
    Fz1_3=-Output.Revolute(numJnt(3)).Fz1(753:end)./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,300])
    plot(t1,Fz1_1);
    hold on
    plot(t2,Fz1_2);
    plot(t3,Fz1_3);
     xlabel('% of Squat')
     ylabel('Force (N/kg)')
     legend('Squat 1', 'Squat 2', 'Squat 3')
    title(strcat('Fz of the',{' '}, lista(3),' joint over time'))

%% Joint Power plots - superposition

lista={'right hip','right knee','right ankle'};
numJnt=[10,11,12];
    M1=-Output.Revolute(numJnt(1)).M1(1:362)./TotalBodyMass;
    M2=-Output.Revolute(numJnt(1)).M1(363:752)./TotalBodyMass;
    M3=-Output.Revolute(numJnt(1)).M1(753:end)./TotalBodyMass;
    thetad1=Output.Revolute(numJnt(1)).thetad(1:362);
    thetad2=Output.Revolute(numJnt(1)).thetad(363:752);
    thetad3=Output.Revolute(numJnt(1)).thetad(753:end);
    P1=(M1.*thetad1')./TotalBodyMass;
    P2=(M2.*thetad2')./TotalBodyMass;
    P3=(M3.*thetad3')./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,200])
    plot(t1,P1);
    hold on
    plot(t2,P2);
    plot(t3,P3);
    line([50,50],[-0.05,0.05],'Color','k','LineStyle','--');
    axis([0 100 -0.05 0.05])
     xlabel('% of Squat')
     ylabel('Joint Power (W/kg)')
     legend('Squat 1', 'Squat 2', 'Squat 3')
    title(strcat('Joint Power of the',{' '}, lista(1),' joint over time'))
    hold off
    
    M1=Output.Revolute(numJnt(2)).M1(1:362)./TotalBodyMass;
    M2=Output.Revolute(numJnt(2)).M1(363:752)./TotalBodyMass;
    M3=Output.Revolute(numJnt(2)).M1(753:end)./TotalBodyMass;
    thetad1=Output.Revolute(numJnt(2)).thetad(1:362);
    thetad2=Output.Revolute(numJnt(2)).thetad(363:752);
    thetad3=Output.Revolute(numJnt(2)).thetad(753:end);
    P1=(M1.*thetad1')./TotalBodyMass;
    P2=(M2.*thetad2')./TotalBodyMass;
    P3=(M3.*thetad3')./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,200])
    plot(t1,P1);
    hold on
    plot(t2,P2);
    plot(t3,P3);
    line([50,50],[-0.05,0.05],'Color','k','LineStyle','--');
    axis([0 100 -0.05 0.05])
     xlabel('% of Squat')
     ylabel('Joint Power (W/kg)')
     legend('Squat 1', 'Squat 2', 'Squat 3')
    title(strcat('Joint Power of the',{' '}, lista(2),' joint over time'))
    hold off
    
    M1=-Output.Revolute(numJnt(3)).M1(1:362)./TotalBodyMass;
    M2=-Output.Revolute(numJnt(3)).M1(363:752)./TotalBodyMass;
    M3=-Output.Revolute(numJnt(3)).M1(753:end)./TotalBodyMass;
    thetad1=Output.Revolute(numJnt(3)).thetad(1:362);
    thetad2=Output.Revolute(numJnt(3)).thetad(363:752);
    thetad3=Output.Revolute(numJnt(3)).thetad(753:end);
    P1=(M1.*thetad1')./TotalBodyMass;
    P2=(M2.*thetad2')./TotalBodyMass;
    P3=(M3.*thetad3')./TotalBodyMass;
    figure()
    set(gcf,'position',[10,10,550,200])
    plot(t1,P1);
    hold on
    plot(t2,P2);
    plot(t3,P3);
    line([50,50],[-0.05,0.05],'Color','k','LineStyle','--');
    axis([0 100 -0.05 0.05])
     xlabel('% of Squat')
     ylabel('Joint Power (W/kg)')
     legend('Squat 1', 'Squat 2', 'Squat 3')
    title(strcat('Joint Power of the',{' '}, lista(3),' joint over time'))
    hold off
