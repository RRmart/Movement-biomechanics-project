function [Body] = yzq(y,Body,NBodies)
% Function to tranfer data from y to r, theta, rdot and thetadot


Ncoordinates=3*NBodies;
for i=1:NBodies
    i1 = 3*i-2;
    i2=i1+1;
    i3= i2+1;
    i4 = i1+Ncoordinates;
    i5 = i4+1;
    i6 = i5+1;
    Body(i).r(1,:) = y(i1:i2,1)'; 
    Body(i).theta(1) = y(i3,1);    
    Body(i).rd(1,:) =y(i4:i5,1)';
    Body(i).thetad(1) = y(i6,1);

    %
    % .. Form the transformation matrix A and B
    cost = cos(Body(i).theta(1));
    sint = sin(Body(i).theta(1));
    Body(i).A = [cost -sint; sint cost];
    Body(i).B =[-sint -cost; cost -sint];
end
% .. Finish function yzq
end