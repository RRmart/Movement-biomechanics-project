function [LabData,Coordinates]= ReadProcessData(Filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This funtion receives the file with the static information %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LabData=struct();

fileID = fopen(Filename);

% Reads the first line of our file
tline = fgetl(fileID);

% Line counter
line= 1;

% Reas the file until finding the tag Marker_Names
while (strcmpi(tline(1:7),'Marker_')==0)
    % Takes the frequency from the file
    if (strcmpi(tline(1:8),'FREQUENC')==1)
        LabData.Frequency = sscanf(tline, '%*s %d');
    end
    
    % Reads the next line
    tline = fgetl(fileID); 
    
    % Update the line counter
    line = line+1;
end

% CLoses the file
fclose(fileID);

% The code above is to skip the first part of our file that only concerns
% aspects of our system.  We only save the sampling frequency, since we
% need it for the filtering

% Reads the rest of the data
Coordinates = dlmread (Filename,'',line+1,2);                                 % We will start on the correct line and always skip the frame and the time instant (already tested)

% Eliminates the third coordinate to project the data onto the sagittal
% plane
Coordinates (:,2:3:end) = [];                                                 %In our case we are eliminating the 2nd coordinate, and only keeping x and z (sagital plane)

% Now we have to go through all different coordinates and perform a
% residual analysis before deciding the cut-off frequency of our low-pass
% filter
NbCoordinates = size(Coordinates,2); 
FilteredCoordinates = [];

for k = 1: NbCoordinates
    FilteredCoordinates (:,k) = (ResidualAnalysis (Coordinates (:,k), LabData.Frequency))/1000; 
end

% Organization of the Coordinates per Body Marker: This is the part in which we say the shoulders and the hips are the average between the two sides

LabData.Coordinates = [FilteredCoordinates(:,1:2) ... % Head
   (FilteredCoordinates(:,3:4)+ FilteredCoordinates(:,9:10))/2 ... % Shoulders
   FilteredCoordinates(:,5:6), ... % Left Elbow,
   FilteredCoordinates(:,7:8) ... % Left Wrist
   (FilteredCoordinates(:,15:16)+FilteredCoordinates(:,27:28))/2, ... % Hips
   FilteredCoordinates(:,11:12),... % Right Elbow
   FilteredCoordinates(:,13:14),... % Right Wrist
   FilteredCoordinates(:,17:18),... % Left Knee
   FilteredCoordinates(:,19:20),... % Left Ankle
   FilteredCoordinates(:,23:24),... % Left Metatarsal
   FilteredCoordinates(:,25:26),... % Left Toe
   FilteredCoordinates(:,29:30),... % Right Knee
   FilteredCoordinates(:,31:32),... % Right Ankle
   FilteredCoordinates(:,35:36),... % Right Metatarsal
   FilteredCoordinates(:,37:38) ]; % Right Toe
 
%    
%    
  end