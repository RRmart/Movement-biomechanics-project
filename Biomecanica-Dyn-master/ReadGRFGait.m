function ReadGRFGait(SamplingFrequency,Filename)
% This function reads and filters the data from the force plates

global FPlate TotalBodyMass


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
RawData(3).fp = fp3;



% Goes through all the force plates and processes the results
for i =1:3
    % Only saves the data that will be relevant to the 2D analysis:
    % Component x and z for each force + center of pressure x and z (in
    % meters)
    FPData= [RawData(i).fp(:,1), RawData(i).fp(:,3),...
        RawData(i).fp(:,4)*1e-3, RawData(i).fp(:,6)*1e-3];
    
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

t=(Time./Time(end)).*100;
figure()
hold on
plot(t,FPlate(1).Data(:,2)./TotalBodyMass,'--')
plot(t,FPlate(2).Data(:,2)./TotalBodyMass)
plot(t,FPlate(3).Data(:,2)./TotalBodyMass,'LineStyle',':','Color','k')
axis([0 100 -2 3])
set(gcf,'position',[10,10,550,300])
title('Component x of Ground Reaction forces')
legend('Plate 1', 'Plate 2', 'Plate 3')
xlabel('% of Stride')
ylabel('Force Magnitude (N/kg)')

figure()
hold on
plot(t,FPlate(1).Data(:,3)./TotalBodyMass,'--')
plot(t,FPlate(2).Data(:,3)./TotalBodyMass)
plot(t,FPlate(3).Data(:,3)./TotalBodyMass,'LineStyle',':','Color','k')
line([t(1),t(end)],[9.8,9.8],'Color','k')
axis([0 100 0 11])
set(gcf,'position',[10,10,550,300])
title('Component z of Ground Reaction forces')
legend('Plate 1', 'Plate 2', 'Plate 3','B.W.')
xlabel('% of Stride')
ylabel('Force Magnitude (N/kg)')


end

