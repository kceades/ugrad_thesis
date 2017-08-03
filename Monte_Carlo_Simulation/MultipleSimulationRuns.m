%% Plots three Monte Carlo simulation traces
% Adjust the parameters for the simulation in the SimulationOneRun function
DataOne = SimulationOneRun();
DataTwo = SimulationOneRun();
DataThree = SimulationOneRun();
M = 4500; % Number of timesteps
times = linspace(1, M, M);
time = times/10^7; % Dividing by the timescale
time = time*10^6; % Setting the timescale for plots to microseconds
hold on % For use with overlays with data or other models
plot(time, DataOne, 'LineWidth', 2,'Color','Magenta')
hold on
plot(time, DataTwo, 'LineWidth', 2,'Color','Red')
hold on
plot(time, DataThree, 'LineWidth', 2,'Color','Green')
xlabel('Time (\mus)','FontSize',25);
ylabel('PMT signal (normalized, negative bias)','FontSize',25);
title('Monte Carlo Simulations for 500 nm Spheres at a 0.8 mm Shooting Distance','FontSize',25);
set(gca,'FontSize',20,'YTick',[-1.0:0.2:0.0],'XGrid','on','XMinorGrid','on');