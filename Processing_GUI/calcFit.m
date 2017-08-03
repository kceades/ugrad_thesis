function [fitData] = calcFit(labData, radius, distance)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
fitData = linspace(1,452,452);
totalNums = 450;
numVels = 50;
simNum = 0;
if radius == 2500
    simNum = 15;
end
if radius == 1000
    simNum = 5;
end
if radius == 500
    simNum = 4;
end
if radius < 500
    simNum = 1;
end
bestVel = 0;
sumSquares = linspace(1, numVels, numVels);
bestSum = 100000;
for n=1:numVels
    sumSquares(n) = 0;
    simVolts = avgSim(simNum, totalNums, n, radius, distance);
    for j=1:totalNums
        sumSquares(n) = sumSquares(n) + (simVolts(j)-labData(j))^2;
    end
    if sumSquares(n) < bestSum
        bestVel = n;
        bestSum = sumSquares(n);
        for j=1:totalNums
            fitData(j) = simVolts(j);
        end
    end
end
fitData(451) = bestVel;
fitData(452) = bestSum;
end