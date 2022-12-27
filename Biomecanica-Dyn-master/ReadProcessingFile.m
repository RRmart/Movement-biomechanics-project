function ReadProcessingFile(FileName,LabData)
%
%... access global memory
%
global NBodies Body Jnt FPlate NFplates
%
%... Read the contents of an input file
%
H = dlmread(FileName);                                                   
%
%... Store the model general dimensions
%
NBodies = H(1,1);
Jnt.NRevolute = H(1,2);
Jnt.NGround = H(1,3);
Jnt.NDriver = H(1,4);
NFplates = H(1,5);
line=1;
%
%... Store the data for the rigid bodies information
%
for i=1:NBodies                                                             %note: we use structures in the program to make it compact
    line = line+1;                                                          % Body contains r and theta
    Body(i).Number = H(line,1);
    Body(i).PtsAdj = H(line,2:3)';                                          % Our body is defined between 2 points, writen in Proximal-Distal way
    Body(i).COM = H(line,4);                                                % Body center of mass, normalized for its length. Here, spPi is only defined by Xsi because the axis is align with the body
    Body(i).mass = H(line,5);
    Body(i).rg = H(line,6);
    Body(i).pi = Body(i).PtsAdj(1);
    Body(i).pj = Body(i).PtsAdj(2);
    Coorpi=Body(i).pi*2-1;
    Coorpj=Body(i).pj*2-1;
    Body(i).Length=mean(vecnorm(abs(LabData.Coordinates(:,Coorpi:Coorpi+1)-LabData.Coordinates(:,Coorpj:Coorpj+1))'));
end
%
%...Store the data for revolute joint
for k=1:Jnt.NRevolute                                                       % The first column is an empty space (number of the revolute joint?)
    line=line+1;
    Jnt.Revolute(k).i = H(line,2);
    Jnt.Revolute(k).j =  H(line,3);
    Jnt.Revolute(k).spPi =  Body(Jnt.Revolute(k).i).Length.*[H(line,4),0];  % vector from the center of mass to the joint in the body reference frame
    Jnt.Revolute(k).spPj =  Body(Jnt.Revolute(k).j).Length.*[H(line,5),0];
end


for k=1:Jnt.NGround                                                         % The first column is an empty space (number of the ground joimt?)
    line=line+1;
    Jnt.Ground(k).i = H(line,2);
  
end

% ... Store the data for drivers (driving constraints)
for k=1:Jnt.NDriver
    line = line+1;
    Jnt.Driver(k).type = H(line,2);                                         % to identify driver type
    Jnt.Driver(k).i = H(line,3);                                            %if the body is of type 1, it is defined by the difference in angle between bodies j and i which share a joint
    Jnt.Driver(k).ctype = H(line,4);
    Jnt.Driver(k).j = H(line,5);
end   
for k =1:NFplates
    line=line+1;
    FPlate(k).Number=H (line,1);
    FPlate(k).i =H (line,2);
    FPlate(k).j =H (line,3);
%     FPlate(k).spi =H (line,4:5)';
%     FPlate(k).spi =H (line,6:7)';
%podemos adicionar o filename de cada force plate
end

line = line+1;
 % -- finish the ReadProcessingFile function
end

%