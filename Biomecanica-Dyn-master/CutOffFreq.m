
H = dlmread('Cut.txt');
H(:,21:22)=[];
H(:,31:32)=[];
Gaitx=H(1,1:2:end);
Gaity=H(1,2:2:end);
Squatx=H(2,1:2:end);
Squaty=H(2,2:2:end);

BarX={'Head','Left Shoulder','Left Elbow','Left Wrist','Right Shoulder','Right Elbow','Right Wrist'...
    'Left Hip','Left Knee','Left Ankle','Left Metatarsal','Left Toe','Right Hip','Right Knee','Right Ankle','Right Metatarsal','Right Toe'};
for i=1:17
    matrix(i,:)=[Gaitx(i),Gaity(i),Squatx(i),Squaty(i)];
end

figure()
X=categorical({'Head','Left Shoulder','Left Elbow','Left Wrist','Right Shoulder','Right Elbow','Right Wrist'...
    'Left Hip','Left Knee','Left Ankle','Left Metatarsal','Left Toe','Right Hip','Right Knee','Right Ankle','Right Metatarsal','Right Toe'});
X=reordercats(X,{'Head','Left Shoulder','Left Elbow','Left Wrist','Right Shoulder','Right Elbow','Right Wrist'...
    'Left Hip','Left Knee','Left Ankle','Left Metatarsal','Left Toe','Right Hip','Right Knee','Right Ankle','Right Metatarsal','Right Toe'});
bar(X,matrix)
legend('Gait x', 'Gait y', 'Squat x', 'Squat y');
title('Cut off frequencies');

