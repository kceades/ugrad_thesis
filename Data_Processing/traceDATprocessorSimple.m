%% This script takes in the first and last .DAT file numbers that are
% to be plotted and outputs the normalized, negative bias PMT signal as
% a function of time since ablation. Note that if some data manipulation
% is desired, the vectors 'actualTimes' and 'actualSumSig' can be called
% in the command window after this script finishes executing
%% The two inputs: the last two digits in the .DAT file names for both
% the first and the last file.
startFile = 15;
endFile = 17;
%% Working with the data, summing it for each time, then normalizing
% to the peak and accounting for any strange minimum behavior.
% The normalized PMT signal is slapped with a negative bias to replicate
% time-of-flight traces (which are the inputs here).
fileNum = endFile-startFile+1;
timeNum = 500; % Based on the number of data points in each .DAT file from
               % our oscilloscope
A = zeros(timeNum, fileNum);
times = zeros(timeNum);
sumSig = zeros(timeNum);
for i=startFile:endFile
    if i<10
        M = csvread(strcat('TEK0000',int2str(i),'.DAT'));
    end
    if i>=10
        M = csvread(strcat('TEK000',int2str(i),'.DAT'));
    end
    for j=1:timeNum
        A(j,i+1) = M(j,2);
        sumSig(j) = sumSig(j) + M(j,2);
    end
end
% Accounting for when the signal actually begins based on time t=0 when
% our photodiode trigger goes off from an ablation pulse
for j=1:timeNum
    times(j) = M(j,1);
    if times(j)<0
        starti = j;
    end
end
starti = starti + 1;
totalNums = timeNum - starti + 1; % Running yields totalNums = 450
actualSumSig = linspace(1,totalNums,totalNums)*0.0;
actualTimes = linspace(1,totalNums,totalNums)*0.0;
minVal = 0;
maxVal = 0;
for k=1:totalNums
    actualSumSig(k) = sumSig(timeNum - totalNums + k);
    if actualSumSig(k) < maxVal
        maxVal = actualSumSig(k);
    end
    if actualSumSig(k) > minVal
        minVal = actualSumSig(k);
    end
    actualTimes(k) = times(timeNum - totalNums + k);
end
% Normalizing
maxVal = maxVal - minVal;
for k=1:totalNums
    actualSumSig(k) = -1.0*(actualSumSig(k) - minVal)/maxVal;
end
%% Plotting the results
% hold on % For use when overlaying with other figures from the other
          % models for example
actualTimes = actualTimes*10^6; % Scaling the times so that the graph is in microseconds
plot(actualTimes,actualSumSig,'LineWidth',2,'Color','Blue') %Adjust color as appropriate
xlabel('Time (\mus)','FontSize',25);
ylabel('PMT signal (normalized, negative bias)','FontSize',25);
title('Comparing Data and First-Principles Model for 5 micron Spheres at a 0.8 mm Shooting Distance','FontSize',25); %Adjust title as appropriate
set(gca,'FontSize',20,'YTick',[-1.0:0.2:0.0],'XGrid','on','XMinorGrid','on');