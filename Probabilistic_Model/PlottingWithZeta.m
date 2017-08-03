%% This script plots the percent of spheres that will be hit by a
%  laser a distance D from the slide as a function of time.  It also
%  returns the greatest percent of the spheres that can be hit and the
%  time at which this would occur.  That is, it returns the optimal
%  firing time for the laser.
%% Parameters: D, the distance from the front edge of the beam (nearest
%  to the slide) to the front edge of the slide (nearest to the beam)
    D = 800.0*10^-6.0;
%  The number of times to discretely sample with.  A larger N increases
%  the run-time significantly, but also allows for a more detailed and 
%  further time window to view it in.
    N = 4500;
%  The timescale on which the bulk of the "significant" action is
%  expected to occur.  Really, just change the values of N and the
%  timescale until a good graph is obtained in which the peak and its
%  decay are clearly visible.
    timescale = 10.0^7.0;
%% The actual plotting, which calls upon the various other functions.
time = linspace(1, N, N);
times = time/timescale;
percents = linspace(1, N, N);
maxpercent = 0.0;
optimalt = 0.0;
for i=1:N
    percents(i) = spheresIndrGap(D, times(i));
    if percents(i) > maxpercent
        maxpercent = percents(i);
        optimalt = times(i);
    end
end
for i=1:N
    percents(i) = -1.0*percents(i)/maxpercent;
end
%% Creating the plot and printing the maximum percent of spheres
%  that can be hit and the optimal time at which the laser should be
%  fired in order to realize this maximum percentage.  Note that
%  the plot has on the y-axis the percent of spheres (0 to 100) that
%  would be hit as a function of time (of the laser firing) on the
%  x-axis.
maxpercent
optimalt
times = times*10^6; % Setting the timescale for plotting to microseconds
hold on % For use with overlaying on data or other model results
plot(times, percents, 'LineWidth', 2,'Color','Black')
% xlabel('Time (\mus)','FontSize',25);
% ylabel('PMT signal (normalized, negative bias)','FontSize',25);
% title('Probabilistic Model for 500 nm Spheres at a 0.8 mm Shooting Distance','FontSize',25);
% set(gca,'FontSize',20,'YTick',[-1.0:0.2:0.0],'XGrid','on','XMinorGrid','on');