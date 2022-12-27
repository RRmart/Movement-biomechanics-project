function PlotResults

global Output

Body = Output.Body;
Time = Output.Time;

%% Position plots
numBody=11;
P1=zeros(length(Time),2);
for i=(1:length(Time))
    r = Body(numBody).r(i,:)';
    theta = Body(numBody).theta(i);
    A = [cos(theta) -sin(theta); sin(theta) cos(theta)];
    P1(i,:) = r-A*[Body(numBody).COM*Body(numBody).Length;0];
end

figure()
plot(Time,P1(:,1))
hold on
plot(Time,P1(:,2))
legend({'x','z'},'Location', 'northwest')
xlabel('Time(s)')
ylabel('Position(m)')
title('x and z coordinates of the hip joint over time')
hold off

lista={'left','right'};
num=[9,13];
for i=(1:length(num))
    figure()
    plot(Time,Body(num(i)).r(:,1))
    hold on
    plot(Time,Body(num(i)).r(:,2))
    legend({'x','z'},'Location', 'best')
    xlabel('Time(s)')
    ylabel('Position(m)')
    title(strcat('x and y coordinates of the ',{' '}, lista(i),' foot over time'))
    hold off
end

numBody=1;
figure()
plot(Time,Body(numBody).r(:,1))
hold on
plot(Time,Body(numBody).r(:,2))
legend({'x','z'},'Location', 'best')
xlabel('Time(s)')
ylabel('Position(m)')
title(strcat('x and z coordinates of the trunk over time'))
hold off

%% angle plots
Jnt = Output.Revolute;
lista={'left hip','right hip','left knee','right knee','left ankle','right ankle'};
numBody=[6,10,7,11,8,12];
for i=(1:length(numBody))
    thetai=Body(Jnt(numBody(i)).i).theta;
    thetaj=Body(Jnt(numBody(i)).j).theta;
    if ismember(numBody(i),[6,10])
        theta=(thetaj-thetai)*180/pi-180; 
    else
        theta=(thetaj-thetai)*180/pi; 
    end
    figure()
%     set(gcf,'position',[10,10,550,200])
    plot(Time,theta);
    xlabel('Time(s)')
    ylabel('Theta(deg)')
    title(strcat('Angle of the',{' '}, lista(i),' joint over time'))
    
    figure()
    thetadi=Body(Jnt(numBody(i)).i).thetad;
    thetadj=Body(Jnt(numBody(i)).j).thetad;
    thetad=thetadj-thetadi;

    plot(Time,thetad);
    xlabel('Time(s)')
    ylabel('Theta(rad/s)')
    title(strcat('Angular velocity of the',{' '}, lista(i),' joint over time'))
    
   
    figure()
    thetaddi=Body(Jnt(numBody(i)).i).thetadd;
    thetaddj=Body(Jnt(numBody(i)).j).thetadd;
    thetadd=thetaddj-thetaddi;
    plot(Time,thetadd);
    xlabel('Time(s)')
    ylabel('Theta(rad/s^2)')
    title(strcat('Angular acceleration of the',{' '}, lista(i),' joint over time'))
 end

%% velocity and acceleration of trunk
numBody=1;
figure()
plot(Time,Body(numBody).rd(:,1))
hold on
plot(Time,Body(numBody).rd(:,2))
legend({'v_x','v_z'},'Location', 'best')
xlabel('Time(s)')
ylabel('Velocity(m/s)')
title(strcat('x and z componets of velocity of the trunk over time'))
hold off

figure()
plot(Time,Body(numBody).rdd(:,1))
hold on
plot(Time,Body(numBody).rdd(:,2))
legend({'a_x','a_z'},'Location', 'best')
xlabel('Time(s)')
ylabel('Acceleration(m/s^2)')
title(strcat('x and z componets of acceleration of the trunk over time'))
hold off

end