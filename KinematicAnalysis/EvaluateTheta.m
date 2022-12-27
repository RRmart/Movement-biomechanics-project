function EvaluateTheta(LabData)

global NBodies Body

Nframes=size(LabData.Coordinates,1);

for i=1:NBodies
    Body(i).theta=zeros(Nframes,1);
    Body(i).eta=zeros(Nframes,2);
    Body(i).r=zeros(Nframes,2);
    for j=1:Nframes
        Coorpi=Body(i).pi*2-1;
        Coorpj=Body(i).pj*2-1;
        % unit vector describing the orientation of the body in the
        % reference frame of the laboratory
        Body(i).csi=(LabData.Coordinates(j,Coorpj:Coorpj+1)-LabData.Coordinates(j,Coorpi:Coorpi+1))./...
        (norm(LabData.Coordinates(j,Coorpj:Coorpj+1)-LabData.Coordinates(j,Coorpi:Coorpi+1)));
        
        %Update the positions of the center of mass from the proximal
        %point in the laboratory reference frame
        Body(i).r(j,:)=LabData.Coordinates(j,Coorpi:Coorpi+1) + Body(i).COM * Body(i).Length*Body(i).csi;
        
        %update the orientation of the body
        if Body(i).csi(2)>0
            Body(i).theta(j)=acos(Body(i).csi*[1,0]');
        else
            Body(i).theta(j)=2*pi - acos(Body(i).csi*[1,0]');
        end
    end
end

    % To ensure continuity
    Body(i).theta = unwrap(Body(i).theta);
end
