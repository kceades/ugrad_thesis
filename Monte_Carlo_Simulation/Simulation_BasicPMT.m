%% Parameters for the beam: radius, distance from the edge of the
%  slide (before the spheres) to the center of the beam
    R = 0.1*10^-3;
    D = 0.9*10^-3;
%  The radius of the sphere
    r = 500*10^-9;
%  Maximum ejection angle (20 degrees):
    thetamax = pi/9;
%% More parameters
%  The number of spheres (100 is convenient to make everything a
%  percentage:
    N = 3251;
%  The most probable velocity V and the appropriate scaling factor 
%  for the Maxwell-Boltzmann distribution (change V as necessary):
    V = 8.3;
    a = V/sqrt(2);
%  Parameters for a Gaussian distribution of the ejection angles, the
%  mean and standard deviation (taking the maximum ejection angle to
%  be at three standard deviations from the mean, which is
%  statistically viable):
    mangle = 0;
    stdangle = thetamax/3;
%% Setting up all the necessary vectors:
    vels = linspace(1, N, N);
    xpos = linspace(1, N, N);
    ypos = linspace(1, N, N);
    zpos = linspace(1, N, N);
    phiangles = linspace(1, N, N);
    thetaangles = linspace(1, N, N);
%% Determining the xpos and ypos of spheres from HCP packing inside
%  the HCP structure
    RA = 30.0*10^-6;
    d = 2*RA;
    endi = ceil(d/(2*r));
    endj = ceil(d/(sqrt(3)*r));
    counter = 1;
    for j=1:endj
        currentheight = RA - sqrt(3)*r*(j - 1);
        for i=1:endi
            if (mod(j, 2) == 1)
                currentwidth = -1*RA + 2*r*i;
            else
                currentwidth = -1*RA + 2*r*i + r;
            end
            if (currentwidth^2 + currentheight^2 < RA^2)
                xpos(counter) = currentwidth;
                ypos(counter) = currentheight;
                counter = counter + 1;
            end
        end
    end
    counter = counter - 1;
    counter
%  Appropriately re-defining all of the vectors to fit the HCP
%  (hexagonal close packing) structure assuming (reasonably to a degree)
%  that the laser strikes a sphere straight on:
    boltzmannvels = randraw('maxwell', a, N);
    for i=1:counter
        vels(i) = boltzmannvels(i);
        zpos(i) = r;
        thetaangles(i) = abs(normrnd(mangle, stdangle));
        phiangles(i) = rand(1)*2*pi;
    end
%% Doing the actual simulation
%  The step size for the simulation
    dt = 10^-7;
%  The number of steps in the simulation
    M = 4500;
%  Setting up the times vector
    times = linspace(1, M, M);
    time = times/10^7;
%  The PMT voltage that will be read out, which is a vector as 
%  it will be time dependent
    voltages = linspace(1, M, M);
%  A scale factor for the PMT voltage
    scale = -1.0/3.0*10^-6;
%  The cross-sectional area of the sphere
    A = pi*r^2;
%  The density of the spheres (in g/cm^3)
    rho = 1.05;
%  The mass of the sphere
    m = pi*4/3*(r*100)^3*rho/1000;
%  The parameter for the Gaussian beam width (at full-width half-max
%  at the edge of the beam waist or radius)
    stdR = R*sqrt(1/(2*log(2)));
%  The y-direction acceleration due to gravity (in m/s/s)
    a = 9.81;
%  Running the simulation through some final time
    maxvoltage = 0.0;
    for i=1:M
        voltages(i) = 0;
        for j=1:counter
            xpos(j) = xpos(j) + vels(j)*dt*sin(thetaangles(j))*cos(phiangles(j));
            ypos(j) = ypos(j) + vels(j)*dt*sin(thetaangles(j))*sin(phiangles(j));
            tempypos = ypos(j) - 1/2*a*(i*dt)^2;
            zpos(j) = zpos(j) + vels(j)*dt*cos(thetaangles(j));
            dFC = sqrt(tempypos^2 + (zpos(j) - D)^2);
            if (dFC <= R)
                add = scale/(stdR*sqrt(2*pi))*exp(-dFC^2/(2*stdR^2));
                voltages(i) = voltages(i) + add;
            end
        end
        if voltages(i)<maxvoltage
            maxvoltage = voltages(i);
        end
    end
    voltages = -1.0*voltages/maxvoltage;
    plot(time, voltages, 'LineWidth', 2)
    xlabel('Time (s)','FontSize',25);
    ylabel('PMT signal (normalized, negative bias)','FontSize',25);
    set(gca,'FontSize',20,'YTick',[-1.0:0.2:0.0],'XGrid','on','XMinorGrid','on');