 %% Dynamic analysis Program
 
 clear all                                                                 
% .. Define Global variables
global NBodies Body Jnt FPlate Output

%% Pre-processing
% Reads the data from the static position: the result of this function is
% already filtered
StaticData = ReadProcessData('trial0001_static.tsv');

% Reads input data for the biomechanical nmodel
% This function reads the input file from the Processing interface: this
% will facilitate things once we start our analysis
ReadProcessingFile('ProcessingFile.txt',StaticData);

% Compute total body mass from ground reaction forces and update the mass
% and inertia of the bodies
ComputeBodyProperties('trial0001_static_f_1.tsv');

% Reads the lab movement data
prompt = 'For analysis of Gait Data type 1 and for analysis of Squat Data type 2: ';
choice=input(prompt);
if choice==1
    Data=ReadProcessData('trial0005_str1.tsv');
    
    % Process the ground reaction forces
    ReadGRFGait(Data.Frequency,'trial0005_str1_f_1.tsv');
elseif choice==2
    Data=ReadProcessData1('trial0006_Squat_arm_front.tsv');
    
    % Process the ground reaction forces
    ReadGRFSquat(Data.Frequency,'trial0006_Squat_arm_front_f_1.tsv');
else
    disp('The input is not valid');
end

% Computes the positions and angles of the body and drivers
EvaluateTheta(Data);

EvaluateDrivers(Data);
 
%% Dinamic Analysis
 
 Frequency=Data.Frequency;
 Time= 0: 1/Frequency : (size(Data.Coordinates,1)-1) / Frequency;
 
 %.. Correct the initial conditions
 tstart=Time(1); % first time frame
 [q,qd,Jac] = CorrectInitialConditions(tstart);
 %
 %.. Form the initial vector
 y0 = [q;qd];
 %
 tspan=[tstart Time(end)];

 % .. Call the Matlab function for the time integration
 [t,y] = ode45(@DynamicFuncEval,Time,y0);
 
 %
Ncoordinates=3*NBodies;
Gint=zeros(Ncoordinates-3,length(Time));
qdd=zeros(Ncoordinates,length(Time));
 for i=1:length(Time)
    % .. Calculate Lagrange multipliers, internal forces and accelerations
    [Gint(:,i),qdd(:,i)] = DynamicLagrange(Time(i),y(i,:)');
 end

 % Save the results in a global variable 
ResultsData(y,Gint,qdd,Time);

% Plot the revelant results
if choice==1
    PlotResults;
else
    PlotResultsSquat;
end

prompt='Do you wish to see an animation of the multibody system? (y/n) [y]: ';
str=input(prompt,'s');
if str=='y'
    Animate
end

% .. Finish the Dynamic Analysis Program