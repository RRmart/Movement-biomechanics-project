%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Build the funtion to perform the postion Analysis%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [q,Jac,Phi] = PositionAnalysis(q,time)                            
%... global variables
global NBodies

NR_Tolerance = 0.000001;                                                    % tolerancia do intervalo no metodo de Newton-Raphson
NR_MaxIter = 50;
% nr máximo de iterações no método de Newton Raphson
% .. initialize local parameters
i=0;
error = 10.0* NR_Tolerance;
Ncoordinates=3*NBodies;
Phi = zeros(Ncoordinates,1);                                                 % vector that contains all constraint equations
Jac = zeros(Ncoordinates,Ncoordinates); 
% .. Start the Newton-Rapson iterative process
%
while (error)>(NR_Tolerance) && (i)<(NR_MaxIter)
    i = i+1;
    % ... Evaluate the constraint equations and Jacobian Matrix
    [Phi,Jac] = FunctEval(q,time,Phi,Jac); 
    Jac=sparse(Jac);
    % ..Evaluate the position correction
    Deltaq = Jac\Phi;
    % .. Correct the Positions
    q = q - Deltaq;
    % .. Evaluate the error
    error = max(abs(Deltaq));
end
% .. finish the position analysis
end




