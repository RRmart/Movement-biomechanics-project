function [FilteredData] = ResidualAnalysis (Data, SamplingFrequency)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% In a residual analysis, we will first apply different low pass filters
%%% to our data, and then, calculate the Residual. After we calculate all residuals, we can plot them, fit a linear 
% regression to the linear part of the graph and determin the cut-off frequency. Once we decide what's the best cut-off
%%% frequency, we will apply the final filter and obtained the already
%%% filtered data

% Cut-off frequencies that we will test in our analysis:
CutOffFreq = 1:0.25:20;                                                     % so will go from 1Hz-20Hz in steps of 0.25 Hz
NbCutOffFreq = length(CutOffFreq);
NbData = length(Data);

% Alocate Memory for the Residual Analysis
Residual = zeros(NbCutOffFreq,1);                                     % For each cut-off frequency, we will obtain a residual

for i = 1: NbCutOffFreq
    % We first calculate the cut-off frequency to create the Butter filter
    Wn = (2 * CutOffFreq(i)) / SamplingFrequency;
    
    % Butterworth parameters
    [Ab,Bb] = butter(2,Wn,'low');
    
    % Filtering of the data     
    FilteredData = filtfilt (Ab,Bb,Data);
    
    %Now that we already have the filtered data, we evaluate the residual
    Residual(i) = sqrt ( sum((Data-FilteredData).^2)/NbData);
end

% Now for each cut-off frequency we already have the residual, as can be
% seen in the graph
% figure;
% plot (CutOffFreq, Residual);
% title('Residuals plotted against the Cut- off frequencies');
% hold on
% The Next step, is to perform the linear fit until the R-squared value is
% smaller than 0.95 (as recommended in the bibliography: Winter)
Rsquared =1;
i = 1;

while (Rsquared > 0.95 && i<NbCutOffFreq)
  X = CutOffFreq(NbCutOffFreq-i:NbCutOffFreq);
  Y = Residual(NbCutOffFreq-i:NbCutOffFreq)'; 
  [mdl,S] = polyfit(X,Y,1);                                                   
  R=corrcoef(X,Y);
  Rsquared=R(1,2)^2;
  i=i+1;
   
end


% Final filtering using the correct Cut-off frequency 

[~,j]=min(abs(Residual-mdl(2)));

FinalCutOffFreq=CutOffFreq(j);

% f=@(x) mdl(1)*x+mdl(2);
% plot(0:0.25:20,f(0:0.25:20));
% scatter(FinalCutOffFreq,mdl(2), 'filled')
% line([FinalCutOffFreq,FinalCutOffFreq], [0, mdl(2)], 'LineStyle', '--');
% xlabel('Cut-Off Frequency')
% ylabel('Residual')
% legend('Residual','linear fit','Final Cut-off frquency')
% hold off

Wn = (2 * FinalCutOffFreq) / SamplingFrequency;
    
% Butterworth parameters
[Ab,Bb] = butter(2,Wn,'low');
    
% Filtering of the data     
FilteredData = filtfilt (Ab,Bb,Data);



end