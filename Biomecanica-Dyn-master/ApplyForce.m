% auxiliary function to add force to a body
function [g]= ApplyForce(g,f,sP)
% .. add force to force vector
g(1:2) = g(1:2)+f;
% .. add transport moment to force vector
g(3)=g(3)+sP(1,1)*f(2,1)-sP(2,1)*f(1,1);
%..finish apply force vector
end