%RMS = Root Mean Square - gives the total power of the EMG data, regardless
%of signal

% Gastrocnemius Medialis
% Tibialis Anterior
% Rectus Femoris
% Biceps Femoris


%%%%%%%%%%%%%%%%%%%
%%PD1_rm for Gait%%
%%%%%%%%%%%%%%%%%%%

PD1_rm = dlmread ('PD1_data_rm.tsv','\t',1,0);

figure

subplot(221)
plot (PD1_rm(:,1),PD1_rm(:,2));
title('RM EMG of Gastrocnemius Medialis for Gait');
xlabel('Time');
ylabel('Amplitude');

subplot(222)
plot (PD1_rm(:,1),PD1_rm(:,3));
title ('RM EMG of Tibialis Anterior for Gait');
xlabel('Time');
ylabel('Amplitude');

subplot (223)
plot (PD1_rm(:,1),PD1_rm(:,4));
title ('RM EMG of Rectus Femoris for Gait');
xlabel('Time');
ylabel('Amplitude');


subplot(224)
plot (PD1_rm(:,1),PD1_rm(:,5));
title ('RM EMG of Biceps Femoris for Gait');
xlabel('Time');
ylabel('Amplitude');



%%%%%%%%%%%%%%%%%%%%%%
%%%PD1_RMS for Gait%%%
%%%%%%%%%%%%%%%%%%%%%%

PD1_RMS = dlmread ('PD1_data_RMS.tsv','\t',1,0);

figure

subplot(221)
plot (PD1_RMS(:,1),PD1_RMS(:,2));
title('RMS EMG of Gastrocnemius Medialis for Gait');
xlabel('Time');
ylabel('Amplitude');

subplot(222)
plot (PD1_RMS(:,1),PD1_RMS(:,3));
title ('RMS EMG of Tibialis Anterior for Gait');
xlabel('Time');
ylabel('Amplitude');

subplot (223)
plot (PD1_RMS(:,1),PD1_RMS(:,4));
title ('RMS EMG of Rectus Femoris for Gait');
xlabel('Time');
ylabel('Amplitude');


subplot(224)
plot (PD1_RMS(:,1),PD1_RMS(:,5));
title ('RMS EMG of Biceps Femoris for Gait');
xlabel('Time');
ylabel('Amplitude');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Squat_rm arms in front%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Squat_rm = dlmread ('Squat Arms in Front_data_rm.tsv','\t',1,0);

figure

subplot(221)
plot (Squat_rm(:,1),Squat_rm(:,2));
title('RM EMG of Gastrocnemius Medialis for Squat');
xlabel('Time');
ylabel('Amplitude');

subplot(222)
plot (Squat_rm(:,1),Squat_rm(:,3));
title ('RM EMG of Tibialis Anterior for Squat');
xlabel('Time');
ylabel('Amplitude');

subplot (223)
plot (Squat_rm(:,1),Squat_rm(:,4));
title ('RM EMG of Rectus Femoris for Squat');
xlabel('Time');
ylabel('Amplitude');


subplot(224)
plot (Squat_rm(:,1),Squat_rm(:,5));
title ('RM EMG of Biceps Femoris for Squat');
xlabel('Time');
ylabel('Amplitude');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Squat_RMS arms in front%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Squat_RMS = dlmread ('Squat Arms in Front_data_RMS.tsv','\t',1,0);

figure
subplot(221)
plot (Squat_RMS(:,1),Squat_RMS(:,2));
title('RMS EMG of Gastrocnemius Medialis for Squat');
xlabel('Time');
ylabel('Amplitude');

subplot(222)
plot (Squat_RMS(:,1),Squat_RMS(:,3));
title ('RMS EMG of Tibialis Anterior for Squat');
xlabel('Time');
ylabel('Amplitude');

subplot (223)
plot (Squat_RMS(:,1),Squat_RMS(:,4));
title ('RMS EMG of Rectus Femoris for Squat');
xlabel('Time');
ylabel('Amplitude');


subplot(224)
plot (Squat_RMS(:,1),Squat_RMS(:,5));
title ('RMS EMG of Biceps Femoris for Squat');
xlabel('Time');
ylabel('Amplitude');

