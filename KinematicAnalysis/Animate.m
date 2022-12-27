
function Animate
% This function plots the animation of our model for a given trial and
% writes it to a video file with a frame rate equal to the one of the lab's
% cameras (100Hz)
global NBodies Output

Body = Output.Body;
Time = Output.Time;

tstep = diff(Time(1:2));
tstart = Time(1);

%Initialize the video
myVideo = VideoWriter('squat'); %open video file
myVideo.FrameRate = 1/tstep;  
open(myVideo)

%for each time step plot each of the bodies
figure();
for i = 1:length(Time)
    for numBody = 1:NBodies
        r = Body(numBody).r(i,:)';
        theta = Body(numBody).theta(i);
        A = [cos(theta) -sin(theta); sin(theta) cos(theta)];
        P1 = r-A*[Body(numBody).COM*Body(numBody).Length;0];
        P2 = r+A*[(1-Body(numBody).COM)*Body(numBody).Length;0];
        if ismember(numBody, [2,1]) %head and trunk
            plot([P1(1) P2(1)], [P1(2) P2(2)],'k.-','MarkerSize',15);
        elseif ismember(numBody, [3,4,7,8,9,10]) %left
            plot([P1(1) P2(1)], [P1(2) P2(2)],'b.-','MarkerSize',15);
        elseif ismember(numBody, [5,6,11,12,13,14])  %right
            plot([P1(1) P2(1)], [P1(2) P2(2)],'r.-','MarkerSize',15);
        end
        hold on
        axis equal %Define axis
        axis([-1 2 -0.500 2]);
%         mTextBox = uicontrol('style','text'); %Create text box for time
%         set(mTextBox,'String',['Time: ',num2str(tstart+i*tstep)]);
%         set(mTextBox,'Position',[120 280 60 15]);
    end
%     pause(tstep);
    frame = getframe(gcf); %get frame
    writeVideo(myVideo, frame);
    hold off;
end

  close(myVideo)