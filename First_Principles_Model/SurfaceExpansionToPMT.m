function [ ] = SurfaceExpansionToPMT( radii, ejectvels )
%% To run this function, first run ExpansionMatrix3D script and then run
% this function using the inputs of RADS(1,:) for radii and Zpmax for 
% ejectvels. This function returns the simulated PMT signal (normalized,
% negative bias) as a function of time since ablation OR the number of
% spheres in the high-intensity laser focus as a function of time since
% ablation, depending on the input parameters. There are various things
% that must be commented/uncommented depending on if using the
% high-intensity laser or the scattering beam
%% Input values
Nspheres = 36254; % Set this equal to the value of counter+1 after running once
rspheres = 250.0*10^(-9.0); % The radius of the deposition spheres
Rscatter = 5*10^(-6.0); % Radius of the scattering beam or THOR focal sphere
                        % 5E-6 is THOR and 100E-6 is scattering
Dscatter = 505*10^(-6.0); % Distance from the sample surface to the center of
                          % the scattering beam or high-intensity focus
                          % Use 600E-6 for scattering at 0.5 mm shooting
                          % distance or 505E-6 for THOR
Ntheta = 0.0; % The misalignment angle to test sensitivity to alignment
timenum = 6000; % The number of timesteps to consider. Use 4500 for replicating
                % time-of-flight traces
timestep = 10^(-7.0); % The timestep. Use 10E-7 for replicating time-of-flight
                      % traces with the timenum of 4500
%% Running everything                          
scattersigR = Rscatter/(2.0*sqrt(2.0*log(2.0)));

vels = zeros(1,Nspheres);
xpos = zeros(1,Nspheres);
ypos = zeros(1,Nspheres);
zpos = zeros(1,Nspheres);

rablate = 50.0*10^(-6.0);
dablate = 2.0*rablate;
endi = ceil(dablate/(2.0*rspheres));
endj = ceil(dablate/(sqrt(3.0)*rspheres));
counter = 1;
for j=1:endj
    currentheight = rablate - sqrt(3.0)*rspheres*(j-1);
    for i=1:endi
        currentwidth = 0.0;
        if (mod(j,2)==1)
            currentwidth = -1.0*rablate+2.0*rspheres*i;
        else
            currentwidth = -1.0*rablate+2.0*rspheres*i+rspheres;
        end
        currentrad = sqrt(currentwidth^2.0+currentheight^2.0);
        if (currentrad<rablate)
            xpos(counter) = currentwidth;
            ypos(counter) = currentheight;
            tempMatrix = abs(radii-currentrad);
            [tempval, tempind] = min(tempMatrix);
            % Use the following velocity in general
            vels(counter) = ejectvels(tempind);
            % Use this for 5 micron spheres with the coefficient of the
            % exponential determined from the peak of the lensing ejection
            % velocity curve from ExpansionMatrix3D
%             vels(counter) = 270*exp(-currentrad^2/(1.5*10^(-5))^2);
            counter = counter + 1;
        end
    end
end
counter = counter-1;
counter
timevals = linspace(1,timenum,timenum)*timestep;
signalout = zeros(1,timenum);
theta=Ntheta*pi/180;
for t=1:timenum
    zpos = zpos + vels*cos(theta)*timestep;
    xpos = xpos + vels*sin(theta)*timestep;
    for j=1:counter
        dFC = sqrt((ypos(j)-0.5*9.81*(t*timestep)^2.0)^2.0+xpos(j)^2.0+(zpos(j)-Dscatter)^2.0); % For the high-intensity laser spherical spot
%         dFC = sqrt((ypos(j)-0.5*9.81*(t*timestep)^2.0)^2.0+(zpos(j)-Dscatter)^2.0); % For the CW scattering beam solid cylinder
        if dFC <= Rscatter
              signalout(t) = signalout(t) + 1.0; % For the high-intensity laser
%             signalout(t) = signalout(t) -
%             exp(-1.0*dFC^2.0/(2.0*scattersigR^2.0)); % For the CW laser
        end
    end
end
%% For the scattering time-of-flight
% signalout = -1.0*signalout/min(signalout);
% edgetime = 0;
% found = 0;
% for t=1:timenum
%     if signalout(t)<-0.995&&found==0
%         edgetime = t*timestep;
%         found=1;
%     end
% end
% edgetime % Spitting out the peak time
%% For the high-intensity laser
started = 0;
ended = 0;
for t=1:timenum
    if signalout(t)>1 && started==0
        started = t;
    end
    if signalout(t)>0
        ended = t;
    end
end
(ended-started)*timestep % Spitting out the total time window a sphere could be hit in
%% Plotting (only use one setup)

% For high-intensity
hold on % For use with other graphs or multiple runs of this function
plot(timevals*10^6, signalout,'LineWidth',2,'Color','Blue') % Change the color as needed
xlabel('Time (\mus)','FontSize',25);
title('500 nm Spheres in the High-Intensity Focus at Time Since Ablation for Various Ablation Intensities','FontSize',25); % Change title as needed
ylabel('Spheres in the focus','FontSize',25);
set(gca,'FontSize',20,'XGrid','on','XMinorGrid','on');

% For scattering
% hold on % For use with other graphs or multiple runs of this function
% plot(timevals*10^6, signalout,'LineWidth',2,'Color','Blue') % Change the color as needed
% xlabel('Time (\mus)','FontSize',25);
% title('Simulated Time-of-Flight Data from First-Principles Model','FontSize',25);
% ylabel('PMT signal (normalized, negative bias)','FontSize',25);
% set(gca,'FontSize',20,'YTick',[-1.0:0.2:0.0],'XGrid','on','XMinorGrid','on');
end