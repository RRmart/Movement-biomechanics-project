function ComputeBodyProperties(Filename)
% This function computes the total body mass and updates the mass and
% inertia of all bodies, after reading the ground reaction forces

global NBodies Body TotalBodyMass

% Transform the data from the local referance frame to the global reference
% frame of the lab
[~,fp2,~]=tsv2mat(0,0,0,Filename);

% Only the force plate 2 was used for the static position. The force was
% saved i the 3rd column
AverageWeight = mean(fp2(:,3));

% F= m*9.8 (Newton's Law)
TotalBodyMass = AverageWeight/9.8;
disp(['The total body mass is ', num2str(TotalBodyMass),' kg']);

% Update of the mass and moment of inertia for all bodies
for i =1:NBodies
    Body(i).mass = Body(i).mass*TotalBodyMass;
    
    Body(i).inertia=Body(i).mass*(Body(i).rg*Body(i).Length)^2;
end

end