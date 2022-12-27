% Function to build the force vector
function [g] = BuildForceVector(t)
% .. Access the global memory
 global NBodies 
 
Ncoordinates=3*NBodies; 
g=zeros(Ncoordinates,1);
%...add gravitational forces
[g] = ForceGravity(g);                                                        %this function will initialize the force vector and add gravitation to it

%.. add Contact Forces
[g] = ForceContact(g,t);                                                    %some of these forces may depend on time
%.. finish the force funtion
end