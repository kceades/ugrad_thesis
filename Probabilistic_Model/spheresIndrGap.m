function [num] = spheresIndrGap(D, t)
%% This function returns the number of spheres in the width of
%  the laser beam a distance D from the slide fired at a time t
% for a duration of about 1 femto-second
%% Parameters of the laser: duration of the pulse dt and width of
%  the beam w
    dt = 1.0*10.0^-7.0;
    w = 200.0*10.0^-6.0;
%% The minimum velocity necessary to reach the front edge of the
%  beam between time t when the laser is fired and t + dt when the
%  pulse ends
    minv = D/(t + dt);
%% The maximum velocity allowed for a sphere to be at the back edge
%  of the beam width at the start of the laser pulse at time t
    maxv = (D + w)/(t*cos(pi/9));
%% Numerical integration using a lower summation method to determine
%  the total number of spheres that will be hit by the laser
    delta = (maxv - minv)/100.0;
    num = 0.0;
    while minv < maxv
        %% The adjustment scaling factor (0 to 1) necessary due to the 
        % spherical cone wavefront (calling the zetaFactor.m function)
            zeta = zetaFactor(D, minv, t);
        %% The number of spheres that would be in the one-dimensional
        % "box" if the spheres were ejected in a straight line.  Note
        %  that spheresPerIntGaussian may be called here instead of
        %  spheresPerInt depending on the desired distribution.  The
        %  current is a Maxwell-Boltzmann distribution, but the
        %  mentioned substitute follows a Gaussian distribution.
            spheres = spheresPerInt(minv, minv + delta);
        %% Updating the number of spheres, accounting for the change
        % from one-dimension to three
            num = num + zeta*spheres;
            minv = minv + delta;
    end
    num = num*100.0;
end