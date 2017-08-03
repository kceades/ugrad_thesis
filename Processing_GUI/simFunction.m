function [voltages] = simFunction(M, V, radius, distance)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%% Parameters for the beam: radius, distance from the edge of the
%  slide (before the spheres) to the center of the beam
    R = 0.1*10^-3;
    D = (distance + 0.5)*10^-3;
%  The radius of the sphere
    r = radius*10^-9;
%  Maximum ejection angle (20 degrees):
    thetamax = pi/9;
%% More parameters
%  The number of spheres (100 is convenient to make everything a
%  percentage:
    N = 1;
    if radius == 2500
        N = 14;
    end
    if radius == 1000
        N = 91;
    end
    if radius == 500
        N = 375;
    end
    if radius == 350
        N = 769;
    end
    if radius == 250
        N = 1512;
    end
    if radius == 150
        N = 4223;
    end
    if radius == 50
        N = 38093;
    end
%  The most probable velocity V and the appropriate scaling factor 
%  for the Maxwell-Boltzmann distribution (change V as necessary):
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
    RA = 10.25*10^-6;
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
    dt = 10^-6;
%  The PMT voltage that will be read out, which is a vector as 
%  it will be time dependent
    voltages = linspace(1, M, M);
%  The parameter for the Gaussian beam width (at full-width half-max
%  at the edge of the beam waist or radius)
    stdR = R*sqrt(1/(2*log(2)));
%  The y-direction acceleration due to gravity (in m/s/s)
    a = 9.81;
%  The Rayleigh length, noting that we have replaced the conventional
%  z-direction with x, so we have an x-Rayleigh
    xRayleigh = pi*R^2/(488.0*10^-9);
%  Running the simulation through some final time
    for i=1:M
        voltages(i) = 0;
        for j=1:counter
            xpos(j) = xpos(j) + vels(j)*dt*sin(thetaangles(j))*cos(phiangles(j));
            ypos(j) = ypos(j) + vels(j)*dt*sin(thetaangles(j))*sin(phiangles(j));
            tempypos = ypos(j) - 1/2*a*(i*dt)^2;
            zpos(j) = zpos(j) + vels(j)*dt*cos(thetaangles(j));
            dFC = sqrt(tempypos^2 + (zpos(j) - D)^2);
            Rnew = R*sqrt(1+(xpos(j)/xRayleigh)^2);
            if (dFC <= Rnew)
                add = -1/(stdR*sqrt(2*pi))*exp(-dFC^2/(2*(stdR*Rnew/R)^2));
                voltages(i) = voltages(i) + add;
            end
        end
    end
end