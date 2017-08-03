function [data] = getDataFromFiles(startFile,endFile)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fileNum = endFile - startFile + 1;
traceNums = 500;
totalNums = 450;
A = zeros(traceNums, fileNum);
sumSig = zeros(traceNums);
data = zeros(totalNums);
maxVal = 0;
minVal = 0;
for i=startFile:endFile
    if i<10
        M = csvread(strcat('TEK0000',int2str(i),'.DAT'));
    end
    if i>=10
        M = csvread(strcat('TEK000',int2str(i),'.DAT'));
    end
    for j=1:traceNums
        A(j,i+1) = M(j,2);
        sumSig(j) = sumSig(j) + M(j,2);
    end
end
for k=1:totalNums
    data(k) = sumSig(traceNums - totalNums + k);
    if data(k) > maxVal
        maxVal = data(k);
    end
    if data(k) < minVal
        minVal = data(k);
    end
end
minVal = minVal - maxVal;
for k=1:totalNums
    data(k) = -1.0*(data(k) - maxVal)/minVal;
end
end