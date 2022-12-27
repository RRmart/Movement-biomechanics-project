function [s,sd,sdd]=MySpline(time,x)
    s=spline(time,x);
    
    % velocity - differentiation of position spline
    sd=zeros(s.pieces,s.order-1);
    
    for i=(1:size(sd,1))
        sd(i,:)= polyder(s.coefs(i,:));
    end
       
    sd=mkpp(time,sd);
    
    % acceleration - differentiation of velocity spline
    sdd=zeros(sd.pieces,sd.order-1);
    
    for i=(1:size(sdd,1))
        sdd(i,:)= polyder(sd.coefs(i,:));
    end
    
    sdd=mkpp(time,sdd);
end