This program models the human body as a 2D multibody system and performs the kinematics analysis of gait and squat movements, through computation of position, velocity and acceleration and using motion data acquired at a lab. The model contains 14 rigid bodies connected by 13 revolute joints.

--

In Matlab, to perform the whole program (perform pre-processing and kinematic analysis) run the script 

"KinematicAnalysis.m"


To obtain EMG Results run the script

"EMGplot.m"

--
The flowchart for the implementation of the program is shown in the file "Flowchart.jpeg". 
The file "ProcessingFile.txt" contains the necessary information about the multibody system to be studied (bodies, joints and drivers, which contain the information for the driving constraints).
