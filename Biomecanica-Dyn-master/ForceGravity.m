function [g] = ForceGravity(g)
%.. Access global memory
global NBodies Body 
%.. Contribution of each body
for i=1:NBodies
    i1=3*i-2;
    i2=i1+1;
   g(i2)=Body(i).mass.*(-9.8);
end
end