%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Build the funtion to perform the postion Analysis%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [q,Jac,Phi] = PositionAnalysis(q,t)                            
%... global variables
global NBodies

NR_Tolerance = 0.00000001;                                                    % tolerancia do intervalo no metodo de Newton-Raphson
NR_MaxIter = 50;
% nr máximo de iterações no método de Newton Raphson
% .. initialize local parameters
i=0;
error = 10.0;
Ncoordinates=3*NBodies;
Phi = ones(Ncoordinates,1)*10^-6;
Jac=zeros(Ncoordinates,Ncoordinates);% vector that contains all constraint equations
% .. Start the Newton-Rapson iterative process
%
while (error)>(NR_Tolerance) && (i)<(NR_MaxIter)
    i = i+1;
    % ... Evaluate the constraint equations and Jacobian Matrix
    [Phi,Jac] = FunctEval0(q,Phi,Jac,t); 
    %Jac=sparse(Jac);
    % ..Evaluate the position correction
    Deltaq = Jac\Phi;
    % .. Correct the Positions
    q = q - Deltaq;
    % .. Evaluate the error
    error = max(abs(Deltaq));
end
% .. finish the position analysis
end




