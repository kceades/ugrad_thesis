%% Takes in the output of the data from the SphereLensingDataProducer
% and produces pretty pictures
makenums = [100 1000 10000]; % The partition numbers to try
makenumsdec = [99.0 999.0 9999.0]; % Partition numbers minus one
endnums = makenums*2/10; % for what fraction of the normalized radius (0 to 1) to view
hold on
for i=1:length(makenums)
    cdata = SphereLensingDataProducer(makenums(i),makenumsdec(i));
    plot(cdata(1,1:endnums(i)),cdata(2,1:endnums(i)),'LineWidth',1.5)
end
% Plotting the output of SphereLensingDataProducer for the different
% partition numbers
xlabel('Radial distance (normalized)','FontSize',25);
ylabel('Intensity (normalized)','FontSize',25);
set(gca,'FontSize',20);
set(gcf,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
axis([0 0.2 0 500]);
[hleg1,hobj1] = legend('N=100','N=1000','N=10000');
textobj = findobj(hobj1,'type','text');
set(textobj,'Interpreter','latex','fontsize',30);
set(hleg1,'position',[0.7 0.7 0.2 0.2]);
set(hobj1,'linewidth',4);