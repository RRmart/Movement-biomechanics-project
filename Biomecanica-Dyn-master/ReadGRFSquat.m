function ReadGRFSquat(SamplingFrequency,Filename)
% This function reads and filters the data from the force plates

global FPlate TotalBodyMass NFplates

NFplates=NFplates-1;

% We once again transform the data from local reference frame of the force plates to
% the global reference frame
[fp1,fp2,fp3] = tsv2mat(0,0,0,Filename); 

fp1=fp1(11:end-10,:);
fp2=fp2(11:end-10,:);
fp3=fp3(11:end-10,:);

% Timme frame
Time = 0: 1/SamplingFrequency : (size(fp1,1)-1) / SamplingFrequency;

% Saves the data into a structure
RawData(1).fp = fp1;
RawData(2).fp = fp2;



% Goes through all the force plates and processes the results
for i =1:2
    % Only saves the data that will be relevant to the 2D analysis:
    % Component x and z for each force + center of pressure x and z (in
    % meters)
    FPData= [RawData(i).fp(:,2), RawData(i).fp(:,3),...
        RawData(i).fp(:,5)*1e-3, RawData(i).fp(:,6)*1e-3];
    
    % Filters the data
    FilteredFPData = FilterForcePlateData(FPData, SamplingFrequency,Time);
    
    
    % Saves the data in an output structure
    FPlate(i).Data = [Time',FilteredFPData];
    [a,~,~]= MySpline(FPlate(i).Data(:,1),FPlate(i).Data(:,2));     % cubic spline in time of force magnitude in x
    FPlate(i).mx=a;
    [a,~,~]= MySpline(FPlate(i).Data(:,1),FPlate(i).Data(:,3));     % cubic spline in time of force magnitude in z
    FPlate(i).mz=a;
    [a,~,~]= MySpline(FPlate(i).Data(:,1),FPlate(i).Data(:,4));     % cubic spline in time of COP in x
    FPlate(i).copx=a;
    [a,~,~]= MySpline(FPlate(i).Data(:,1),FPlate(i).Data(:,5));     % cubic spline in time of COP in z
    FPlate(i).copz=a;
end
% ploting GR forces for literature comparison

Time1=Time(1:362);
Time2=Time(363:752);
Time3=Time(753:end);
t1=(Time1./(Time1(end)-Time1(1))).*100;
t2=((Time2-Time2(1))./(Time2(end)-Time2(1))).*100;
t3=((Time3-Time3(1))./(Time3(end)-Time3(1))).*100;

Data1_1=FPlate(1).Data(1:362,:);
Data1_2=FPlate(1).Data(363:752,:);
Data1_3=FPlate(1).Data(753:end,:);

Data2_1=FPlate(2).Data(1:362,:);
Data2_2=FPlate(2).Data(363:752,:);
Data2_3=FPlate(2).Data(753:end,:);

figure()
hold on
plot(t1,Data1_1(:,2)./TotalBodyMass)
plot(t2,Data1_2(:,2)./TotalBodyMass)
plot(t3,Data1_3(:,2)./TotalBodyMass)
axis([0 100 -1 1])
set(gcf,'position',[10,10,550,300])
title('Component x of Ground Reaction forces - Plate 1')
legend('Squat 1', 'Squat 2', 'Squat 3')
xlabel('% of Squat')
ylabel('Force Magnitude (N/kg)')

figure()
hold on
plot(t1,Data1_1(:,3)./TotalBodyMass)
plot(t2,Data1_2(:,3)./TotalBodyMass)
plot(t3,Data1_3(:,3)./TotalBodyMass)
%axis([0 100 0 1])
set(gcf,'position',[10,10,550,300])
title('Component z of Ground Reaction forces - Plate 1')
legend('Squat 1', 'Squat 2','Squat 3')
xlabel('% of Squat')
ylabel('Force Magnitude (N/kg)')

figure()
hold on
plot(t1,Data2_1(:,2)./TotalBodyMass)
plot(t2,Data2_2(:,2)./TotalBodyMass)
plot(t3,Data2_3(:,2)./TotalBodyMass)
axis([0 100 -1 1])
set(gcf,'position',[10,10,550,300])
title('Component x of Ground Reaction forces - Plate 2')
legend('Squat 1', 'Squat 2', 'Squat 3')
xlabel('% of Squat')
ylabel('Force Magnitude (N/kg)')

figure()
hold on
plot(t1,Data2_1(:,3)./TotalBodyMass)
plot(t2,Data2_2(:,3)./TotalBodyMass)
plot(t3,Data2_3(:,3)./TotalBodyMass)
%axis([0 100 0 1])
set(gcf,'position',[10,10,550,300])
title('Component z of Ground Reaction forces - Plate 2')
legend('Squat 1', 'Squat 2','Squat 3')
xlabel('% of Squat')
ylabel('Force Magnitude (N/kg)')

end
