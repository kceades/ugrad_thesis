function [voltages] = avgSim(N, M, V, radius, distance)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
voltages = linspace(1,M,M);
minVal = 0;
for i=1:M
    voltages(i) = 0;
end
if N > 1
    for j=1:N
        simVolts = simFunction(M, V, radius, distance);
        for i=1:M
            voltages(i) = voltages(i) + simVolts(i);
        end
    end
end
if N == 1
    simVolts = simFunction(M, V, radius, distance);
    for i=1:M
        voltages(i) = voltages(i) + simVolts(i);
    end
end
for i=1:M
    if voltages(i) < minVal
        minVal = voltages(i);
    end
end
for j=1:M
    voltages(j) = -1.0*voltages(j)/minVal;
end
end