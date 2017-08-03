%% Plots the heat map of the log of the intensity on the surface of
% the silicon after being lensed. 
N = 1000; % Number of partitions
M = 999.0; % N - 1, decimalitized
R = 1;
deltar = R/M;
na = 1.0; % index of refraction of air
ns = 1.615; % index of refraction of polystyrene
nui = 1.0/pi; % for normalizing to a total input power of 1
thetavals = linspace(1,N,N);
nuivals = linspace(1,N,N);
nufvals = linspace(1,N,N)*0.0;
xivals = linspace(1,N,N);
xfvals = linspace(1,N,N);
rvals = linspace(1,N,N);
energies = linspace(1,N,N)*0.0;
sumenergies = linspace(1,N,N)*0.0;
z = zeros(N+1,N+1);
plotx = -1.0:2.0/N:1.0;
for i=1:N
    rvals(i) = ((i-1.0)/M)*R;
    nuivals(i) = nui;
    nufvals(i) = 0.0;
    thetavals(i) = ((i-1.0)/M)*(pi/2.0);
    ctheta = thetavals(i);
    xivals(i) = -1.0*R*sin(ctheta);
    alpha = asin(na*sin(ctheta)/ns);
    L = 2.0*R*cos(alpha);
    deltaxc = L*sin(ctheta-alpha);
    H = R*(1.0-cos(2.0*alpha-ctheta));
    deltaxa = H*tan(2.0*alpha);
    if ctheta >= 2.0*alpha
        deltaxa = H*tan(2.0*ctheta-3.0*alpha); 
    end
    xfvals(i) = xivals(i) + deltaxc + deltaxa;
    if (2.0*ctheta-3.0*alpha) >= (pi/2.0)
        xfvals(i) = 2.0*R;
    end
    if i > 1
        energies(i-1) = nui*pi*(xivals(i)^2-xivals(i-1)^2);
    end
end
for i=1:N
    xfvals(i) = abs(xfvals(i));
end
energies(N) = 0;
for i=1:N
    for j=1:N
        if xfvals(i) >= rvals(j) && xfvals(i) < (rvals(j) + deltar)
            nufvals(j) = nufvals(j) + energies(i);
        end
    end
end
nufvals(1) = nufvals(1)/(pi*rvals(2)^2);
for j=2:N-1
    nufvals(j) = nufvals(j)/(pi*(rvals(j+1)^2-rvals(j)^2));
end
nufvals = nufvals/nuivals(1);
for i=1:N+1
    for j=1:N+1
        xnorm = ((i-1.0)-N/2.0)/(N/2.0);
        ynorm = ((j-1.0)-N/2.0)/(N/2.0);
        cr = sqrt(xnorm^2 + ynorm^2);
        z(i,j) = 1.0;
        for m=1:N-1
            if cr >= rvals(m) && cr < rvals(m+1)
                z(i,j) = z(i,j) + nufvals(m);
            end
        end
        z(i,j) = log(z(i,j));
        if cr>0.99 && cr<1.01
            z(i,j) = 1;
        end
    end
end
fig = figure;
colormap('default');
imagesc(plotx,plotx,z);
% axis([-0.2 0.2 -0.2 0.2]); % for a zoomed view
set(gcf,'OuterPosition', [0 0 1200 1200]);
colorhand = colorbar;
ylabel(colorhand,'Log[intensity (normalized)]','FontSize',25);
xlabel('x (normalized)','FontSize',25);
ylabel('y (normalized)','FontSize',25);
set(gca,'FontSize',20);