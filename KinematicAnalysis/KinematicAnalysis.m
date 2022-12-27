%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kinematics Analysis Code %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all                                                                   
% .. Define Global variables
global NBodies Body

%% Pre-processing
% Reads the data from the static position: the result of this function is
% already filtered
StaticData = ReadProcessData('trial0001_static.tsv');

% Reads input data for the biomechanical nmodel
% This function reads the input file from the Processing interface: this
% will facilitate things once we start our analysis
ReadProcessingFile('ProcessingFile.txt',StaticData);

% Reads the lab movement data - uncomment the one wanted
prompt = 'For analysis of Gait Data type 1 and for analysis of Squat Data type 2: ';
if input(prompt)==1
    Data=ReadProcessData('trial0005_str1.tsv');
elseif input(prompt)==2
    Data=ReadProcessData1('trial0006_Squat_arm_front.tsv');
else
    prompt='The input is not valid';
end
% Computes the positions and angles of the body and drivers
EvaluateTheta(Data);

EvaluateDrivers(Data);
                                            
%% Kinematic Model

Nframes=size(Data.Coordinates,1);                                        
Time = 0:1/Data.Frequency : (Nframes -1)/ Data.Frequency;

%Build vector with initial positions
q=zeros(3*NBodies,length(Time));
q0=zeros(NBodies,1);
for i=1:NBodies
    q0(3*i-2,1) = Body(i).r(1,1);
    q0(3*i-1,1)=Body(i).r(1,2);
    q0(3*i,1)= Body(i).theta(1);
end
% .. For each time step, perform kinematic analysis
qd=zeros(3*NBodies,length(Time));
qdd=zeros(3*NBodies,length(Time));

for i=1:length(Time)
    % .. Perform the position analysis
    [q(:,i),Jac,Phi] = PositionAnalysis(q0,i);
    % .. Perform the velocity analysis
    qd(:,i) = VelocityAnalysis(i,Jac);
    % .. Perform the acceleration analysis
    qdd(:,i) = AccelerationAnalysis(qd(:,i),i,Jac);
    % Update time step counter
    q0=q(:,i);
end

%% Results
% .. Report results
ResultsData(Data,q,qd,qdd);

PlotResults;

prompt='Do you wish to see an animation of the multibody system? (y/n) [y]: ';
str=input(prompt,'s');
if str=='y'
    Animate
end
% .. Terminate the program

