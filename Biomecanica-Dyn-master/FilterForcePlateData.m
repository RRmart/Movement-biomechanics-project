function ProcessedData=FilterForcePlateData(ProcessedData,SamplingFrequency,Time)
%%%

global TotalBodyMass

%for plotting
t=(Time./Time(end)).*100;
ylimits=[-2 3; 0 11];
list=["fx","fz"];


ContactTimeSteps = find(ProcessedData(:,2) > 5); % Only the time steps in wich the force is larger than 5 N will be considered as moments of contact
ContactIndices = (ProcessedData(:,2)>5);

% Filters the forces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j = 1:2
    % In case we want to see the plot of the results  
%     figure()
%     plot(t,ProcessedData(:,j)./TotalBodyMass);
%     hold on;
    FilteredData = LowPassFilter(ProcessedData(:,j), 10, SamplingFrequency);
    
    % The instants of time considered to be moments of no contact, will be
    % assigned to 0
    FilteredData(~ContactIndices) = 0;
    
    % Output update
    ProcessedData (:,j) = FilteredData;
    
    % In case we want to see the plot of the results 
%    plot(t,FilteredData./TotalBodyMass,'r'); 
%    axis([0 100 ylimits(j,1) ylimits(j,2)])
%    title(strcat('Raw and filtered data from Ground Reaction force -', list(j)));
%    legend('Raw','Filtered');
%    xlabel('% of Stride');
%    ylabel('Force Magnitude (N/kg)');
%    hold off;
end

% Filters the centers of pressure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=3:4
    % Instead of having the  value of the CoP going into the origin of the
    % plate, I put the value to be the last value known as a position of
    % contact, so that we don't have a sudden change in the CoP
    RawCoP = ProcessedData(:,j);
    CoP=RawCoP;
    if (ContactTimeSteps(1) > 1)
        CoP(1: ContactTimeSteps(1)-1) = RawCoP(ContactTimeSteps(1));
    end
    if (ContactTimeSteps(end) <length(RawCoP))
        CoP(ContactTimeSteps(end)+1:end) = RawCoP(ContactTimeSteps(end));
    end
    
   FilteredData = LowPassFilter(CoP,10,SamplingFrequency);
   
   % New update of the output
   ProcessedData(:,j) = FilteredData;
   
   % In case we want to see the plot of the results
%    figure()
%    plot(t,RawCoP);
%    hold on;
%    plot(t,CoP);
%    plot(t,FilteredData,'r'); 
%    title('Raw, filtered and Processed data from Center of pressure position in x');
%    legend('Raw','Filtered','Processed');
%    xlabel('% of Stride');
%    ylabel('COP position (m)');
%    hold off;
%    pause
end

end
