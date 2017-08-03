function [datavec] = SphereLensingDataProducer(N,M)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
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
for i=1:N
    rvals(i) = ((i-1.0)/M)*R;
    nuivals(i) = nui;
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
    if i>1
        energies(i) = nui*pi*(xivals(i)^2-xivals(i-1)^2);
    end
end
for i=1:N
    xfvals(i) = abs(xfvals(i));
end
for i=1:N
    for j=1:N
        if xfvals(i) >= rvals(j) && xfvals(i) < (rvals(j) + deltar)
            nufvals(j) = nufvals(j) + energies(i);
        end
    end
end
for i=1:N
    for j=1:i
        sumenergies(i) = sumenergies(i) + nufvals(j);
    end
end
nufvals(1) = nufvals(1)/(pi*rvals(2)^2);
for j=2:N-1
    nufvals(j) = nufvals(j)/(pi*(rvals(j+1)^2-rvals(j)^2));
end
nufvals = nufvals/nuivals(1);
% In the second slot of datavec, use nufvals for the mapped intensity and
% sumenergies for the total power absorbed as a function of radius
datavec = [rvals; nufvals];
end