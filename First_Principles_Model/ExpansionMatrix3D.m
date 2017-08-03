%% Constants throughout the computation.  The absorption coefficient
%  and index of refraction depend on the wavelength of the incident
%  light (in vacuum).  Here, we use the 532 nm wavelength of the green
%  laser.
N = 500; % Number of partitions for the z axis.
M = 1000; % Number of partitions for the r axis.
T = 4000; % Total number of timesteps.
dt = 1.0*10^(-11.0); % Timestep used in the numerical simulation.
R = 50.0*10^(-6.0); % Total radial distance we will consider
                    % in the simulation.
FWHM = 24.0*10^(-6.0); % Beam waist FWHM of the green laser at
                       % its focus.
dr = R/M; % The radial width of each box.
Tamb = 294.5; % Room temperature at 70 degrees F
c = 299792458.0; % Speed of light in vacuum.
po = 2330.0; % Initial density of the silicon.
Nd = 1000.0; % Decimal number of partitions.
Zo = 500.0*10^(-6.0); % Initial thickness of the silicon.
n = 3.42; % Index of refraction.
vlight = c/n; % Speed of light in silicon.
a = 7.85*10^(5.0); % alpha, or the absorption coefficient.
Ap = 1.77*10^(-8.0); % The area hit by the green ablating laser.
Ep = 3.25*10^(-4.0); % The total energy in the green
                     % ablating laser pulse.
s = 5.67*10^(-8.0); % Stefan-Boltzmann constant
                    % (really should be a sigma).
sigz = 0.1; % Standard z deviation for green laser
            % (if normalized to be from -0.5 to 0.5).
sigr = FWHM/(2.0*sqrt(2.0*log(2.0))); % Standard r deviation
                                      % for green laser
                                      % (no normalization)
tp = 20.0*10^(-9.0); % The time duration of the green
                     % ablating laser pulse.
tdelay = 5.0*10^(-10); % The time delay before the laser hits.
npstart = ceil(tdelay/dt); % Starting time index for the pulse.
npend = ceil((tp+tdelay+Zo/vlight)/dt); % End index for the pulse.
Zdiff = vlight*tp; % Magnitude of the range of Z values for the
                   % pulse.
Zmin = 0.0; % Used in the laser heat part: lowest Z value of the
            % laser.
Zmax = 0.0; % Used in the laser heat part: biggest Z value of the
            % laser.
Zavg = 0.0; % Used in the laser heat part: average Z value of the
            % laser.
%% "Constants" that vary with the temperature.  Eventually will be
%  loaded in from a graph or data file into a vector.
aL = 4.86*10^(-6.0); % The coefficient for linear thermal expansion.
k = 131.0; % Thermal conductivity.
e = 0.5; % Emissivity.
cp = 700.0; % Specific heat capacity of the silicon.
%% Setting up the various matrices that will be used in the 
%  simulation.
u = zeros(N,M); % Temperature at a given z and r value.
uo = zeros(N,M); % "Old" temperature to keep track of the temp of
                 % each box before updating in the given timestep.
L = zeros(N,M); % Length at a given z and r value.
Z = zeros(T,M); % Thickness of the silicon at a given time, as a
                % function of radius.
Zp = zeros(T,M); % Rate of change of the silicon thickness at a given
                 % time.
Zh = zeros(N,M); % For the laser heat part: accounts for relative
                 % depth in the silicon wafer.
Zatt = zeros(N,M); % For the laser heat part: accounts for the
                   % max thickness of the silicon as a function
                   % of the radial distance of the box.
RADS = zeros(N,M); % Radius values.  This is a constant matrix.
DTZ = zeros(N,M); % Used in the heat equation part.  Second
                  % derivative of the temperature with respect to z
                  % at a given z and r.
DOR = zeros(N,M); % Used in the heat equation part.  First
                  % derivative of the temperature with respect to
                  % r at a given z and r.
DTR = zeros(N,M); % Used in the heat equation part.  Second
                  % derivative of the temperature with respect to r
                  % at a given z and r.
AMB = zeros(N,M); % Ambient temperature matrix.  This will have the
                  % ambient temperature in the top and bottom rows
                  % for the surfaces of the silicon and will be set
                  % equal to uo matrix elsewhere.
GammaMult = zeros(N,M); % For lensing
repeatDs = 0.0:5.0*10^(-6.0):50.0*10^(-6.0); % For lensing
%% Initializing the radius matrix.
RADS(:,1) = RADS(:,1) + dr/2.0;
for j=2:M
    RADS(:,j) = RADS(:,j-1) + dr;
end
for i=1:N
    %Use the following two for lensing
%     GammaMult(i,:) = 75.0*pulstran(RADS(1,:),repeatDs,@rectpuls,0.5*10^(-6.0));
%     GammaMult(i,1:(50)) = GammaMult(i,1:50)*2.0;
    %Use the following for non-lensing
    GammaMult(i,:) = 1.0;
end
%% Initializing the lengths of the boxes.
L = L + 1.0;
L = L*Zo/N;
%% Initializing the temperature matrices to the appropriate values
%  for the first iteration of the simulation.
u = u + Tamb;
uo = uo + u;
%% Running the simulation through all the timesteps.  Note this will
%  involve a lot of matrix operations to (hopefully) speed up what
%  will otherwise take a very, very long time to run if many
%  z, r and t partitions are use.
%% Running up until the laser begins to hit the silicon surface.
for t=1:(npstart-1)
    %% Setting the values for Z and Zp as a function of radius, which
    %  are both constant as no heat is lost or gained before the
    %  laser interaction.  Note Zp just stays zero so there is no
    %  need to update it.
    Z(t,:) = Z(t,:) + Zo;
end
%% Running through the time in which the laser is interacting with
%  the silicon.
for t=npstart:npend
    %% Updating the temperature.
    % Setting up the ambient temperature matrix.
    AMB = uo;
    AMB(1,:) = AMB(1,:).*0.0 + Tamb;
    AMB(N,:) = AMB(N,:).*0.0 + Tamb;
    % Calculating the partial derivative with respect to z for each
    % box.
    DTZ(1,:) = 8.0*((uo(2,:)-uo(1,:))./(L(2,:)+L(1,:))-(uo(1,:)-AMB(1,:))./L(1,:))./(L(1,:)+2.0*L(2,:));
    DTZ(N,:) = 8.0*((AMB(N,:)-uo(N,:))./L(N,:)-(uo(N,:)-uo(N-1,:))./(L(N,:)+L(N-1,:)))./(L(N,:)+2.0*L(N-1,:));
    for i=2:(N-1)
        DTZ(i,:) = 4.0*((uo(i+1,:)-uo(i,:))./(L(i+1,:)+L(i,:))-(uo(i,:)-uo(i-1,:))./(L(i,:)+L(i-1,:)))./(L(i+1,:)+L(i-1,:));
    end
    % Calculating the partial derivative with respect to r for each
    % box.  We calculate both the first and second derivatives.
    DOR(:,1) = (u(:,2)-u(:,1))/(dr*2.0);
    DOR(:,M) = (u(:,M)-u(:,M-1))/(dr*2.0);
    for j=2:(M-1)
        DOR(:,j) = (u(:,j+1)-u(:,j-1))/(dr*2.0);
    end
    DTR(:,1) = 2.0*DOR(:,1)/dr;
    DTR(:,M) = -2.0*DOR(:,M)/dr;
    for j=2:(M-1)
        DTR(:,j) = (u(:,j+1)-2.0*u(:,j)+u(:,j-1))/dr^(2.0);
    end
    % Updating the temperature from the heat diffusion effects
    u = u + dt*k*Zo*(DTZ+DOR./RADS+DTR)/(cp*N*po)./L;
    % Accounting for thermal radiation.
    u = u - Zo*e*s*dt*(uo-AMB).^(4.0)/(cp*po*N)./(L.^(2.0));
    % Setting up the Zh matrix.
    Zh(N,:) = L(N,:);
    for i=1:(N-1)
        Zh(N-i,:) = Zh(N-i+1,:)+L(N-i,:);
    end
    % Accounting for the heat input from the green laser.
    for i=1:N
        Zatt(i,:) = Z(t-1,:);
    end
    Zmin = Zo - vlight*(t*dt-tdelay);
    Zmax = Zmin + vlight*tp;
    Zavg = (Zmin + Zmax)/2.0;
    % Have a factor of 0.97 for 5 micron and 0.997 for other sizes (that
    % comes from 500 nm, but is similar for others)
    u = u + 0.997*0.9066*GammaMult.*L.^(-2.0)*2.0*n*Ep*Zo/((1.0+2.0*n+n^2.0)*tp*Ap*cp*N*po*(sigr/R)*sigz*pi)*dt.*exp(-1.0*((Zh-Zavg)/Zdiff).^2.0/(2.0*sigz^2.0)).*exp(-1.0*RADS.^(2.0)/(2.0*sigr^2.0)).*exp(-a*(Zatt-Zh)).*(-1.0*exp(-a*L)+1.0);
    %% Updating the lengths.
    L = L + aL*(u-uo).*L;
    %% Calculating and storing the silicon thickness as a function
    %  of radius.
    Z(t,:) = sum(L);
    %% Calculating and storing the rate of expansion or compression
    %  of the silicon surface as a function of radius.
    Zp(t,:) = (Z(t,:)-Z(t-1,:))/dt;
    %% Updating the old temperature for the next time iteration.
    uo = u;
end
%% Running through the time the laser has ceased interaction with
%  the surface until the end of the simulation.
for t=(npend+1):T
    %% Updating the temperature.
    % Setting up the ambient temperature matrix.
    AMB = uo;
    AMB(1,:) = AMB(1,:).*0.0 + Tamb;
    AMB(N,:) = AMB(N,:).*0.0 + Tamb;
    % Calculating the partial derivative with respect to z for each
    % box.
    DTZ(1,:) = 8.0*((uo(2,:)-uo(1,:))./(L(2,:)+L(1,:))-(uo(1,:)-AMB(1,:))./L(1,:))./(L(1,:)+2.0*L(2,:));
    DTZ(N,:) = 8.0*((AMB(N,:)-uo(N,:))./L(N,:)-(uo(N,:)-uo(N-1,:))./(L(N,:)+L(N-1,:)))./(L(N,:)+2.0*L(N-1,:));
    for i=2:(N-1)
        DTZ(i,:) = 4.0*((uo(i+1,:)-uo(i,:))./(L(i+1,:)+L(i,:))-(uo(i,:)-uo(i-1,:))./(L(i,:)+L(i-1,:)))./(L(i+1,:)+L(i-1,:));
    end
    % Calculating the partial derivative with respect to r for each
    % box.  We calculate both the first and second derivatives.
    DOR(:,1) = (u(:,2)-u(:,1))/(dr*2.0);
    DOR(:,M) = (u(:,M)-u(:,M-1))/(dr*2.0);
    for j=2:(M-1)
        DOR(:,j) = (u(:,j+1)-u(:,j-1))/(dr*2.0);
    end
    DTR(:,1) = 2.0*DOR(:,1)/dr;
    DTR(:,M) = -2.0*DOR(:,M)/dr;
    for j=2:(M-1)
        DTR(:,j) = (u(:,j+1)-2.0*u(:,j)+u(:,j-1))/dr^(2.0);
    end
    % Updating the temperature from the heat diffusion effects.
    u = u + dt*k*Zo*(DTZ+DOR./RADS+DTR)/(cp*N*po)./L;
    % Accounting for thermal radiation.
    u = u - Zo*e*s*dt*(uo-AMB).^(4.0)/(cp*po*N)./(L.^(2.0));
    %% Updating the lengths.
    L = L + aL*(u-uo).*L;
    %% Calculating and storing the silicon thickness as a function
    %  of radius.
    Z(t,:) = sum(L);
    %% Calculating and storing the rate of expansion or compression
    %  of the silicon surface as a function of radius.
    Zp(t,:) = (Z(t,:)-Z(t-1,:))/dt;
    %% Updating the old temperature for the next time iteration.
    uo = u;
end
%% Note in the following two sections that only one of the plotting
%  portions should be uncommented (comment out one of the section's
%  plot commands to view whichever data you want to look at).

%% Plotting the silicon thickness as a function of radius and time.
%  To do this, we first create a couple more matrices.

timespace = zeros(T,M);
radspace = zeros(T,M);
for t=1:T
    radspace(t,:) = RADS(1,:);
end
for j=1:M
    timespace(:,j) = linspace(1,T,T)*dt;
end

%% Heat map
% fig = figure;
% colormap('default');
% imagesc(RADS(1,:)*10^6,linspace(1,T,T)*dt*10^9,Z*10^6);
% colorhand = colorbar;
% ylabel(colorhand,'Silicon Thickness (\mum)','FontSize',25);
% xlabel('Radius \mum)','FontSize',25);
% ylabel('Time (ns)','FontSize',25);
% title('Silicon Surface Expansion: Heat Map','FontSize',25);
% set(gca,'FontSize',20);

%% Mesh grid view
% mesh(timespace*10^9,radspace*10^6,Z*10^6);
% xlabel('Time (ns)','FontSize',25);
% ylabel('Radius (\mum)','FontSize',25);
% zlabel('Silicon Thickness (\mum)','FontSize',25);
% title('Silicon Surface Expansion with Ball Lensing','FontSize',25);
% set(gca,'FontSize',20);
% view(-115,25) % for the overall view
% view(0,0) % for the time view
% view(90,0) % for the radial view

%% Finding and plotting the ejection velocities of the spheres
%  as a function of radius, as well as ejection angles
[Zpmax, maxind] = max(Zp);

thetadist = linspace(1,M,M)*0.0;
for i=2:(M-1)
    thetadist(i) = atan((Z(maxind(i),i-1)-Z(maxind(i),i+1))/(2.0*dr));
end

%% Ejection velocity plot
% plot(RADS(1,:)*10^6,Zpmax,'LineWidth',3)
% xlabel('Radius (\mum)','FontSize',25);
% ylabel('Ejection Velocity (m/s)','FontSize',25);
% title('Silicon Surface Expansion with Ball Lensing: Ejection Velocities','FontSize',25);
% set(gca,'FontSize',20);

%% Ejection angle plot
% plot(RADS(1,:)*10^6,thetadist*10^3,'LineWidth',3)
% xlabel('Radius (\mum)','FontSize',25);
% ylabel('Ejection Angle \theta (milliradians)','FontSize',25);
% title('Silicon Surface Expansion After Ablation: Ejection Angles','FontSize',25);
% set(gca,'FontSize',20);