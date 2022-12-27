%% joint moment plots
function plotGint(Gint,Time)

for i=(1:size(Gint,1))
    figure()
%     set(gcf,'position',[10,10,550,200])
    plot(Time,Gint(i,:));
%     xlabel('Time(s)')
%     ylabel('Theta(deg)')
   % title(strcat('Angle of the',{' '}, lista(i),' joint over time'))
end