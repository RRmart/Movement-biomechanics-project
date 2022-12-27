function FilteredData = LowPassFilter(Data, CutOffFreq, SamplingFrequency)
 % We first calculate the cut-off frequency to create the Butter filter
 Wn = (2 * CutOffFreq) / SamplingFrequency;
    
 % Butterworth parameters
 [Ab,Bb] = butter(2,Wn,'low');
    
 % Filtering of the data     
 FilteredData = filtfilt (Ab,Bb,Data);
end