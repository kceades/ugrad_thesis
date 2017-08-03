function [zeta] = zetaFactor(D, v, t)
%% This function calculates and returns a corrective scaling factor
%  to adjust the linear one-dimensional "spheres in the box"
%  calculation in order to account for the three-dimensional spherical
%  cone wavefront of the ejected spheres.  Specifically, it returns
%  the percent of spheres in the wavefront of velocity v that will be
%  hit by the laser a distance D from the slide at time t.
%% One of two parameters that can be changed (though it is likely a
%  good value by default here): the maximum angle of ejection for the
%  spherical cone.  Currently, it is 20 degrees.
    phi = pi/9.0;
%% The second parameter that may be adjusted: the radius of the beam
%  width
    R = 100.0*10.0^-6.0;
%% The distance the spheres in the wavefront of velocity v have
%  travelled
    d = v*t;
%% The total surface area of the spherical wavefront that the spheres
%  are covering
    area = 2.0*pi*d^2.0*(1-cos(phi));
%% The distance to the center of the beam
    B = D + R;
%% A value used in calculating ymin, the smallest value of y in the
%  intersection
    A = d^2.0+2*R*D+D^2.0;
%% A check on ensuring that the spherical wavefront is actually
%  in the beam for at least some part (as this function is only called
%  if this is true)
    if D > d
        d = D;
    end
%% The angle formed with the outermost edge of the instersection
    theta = acos(D/d);
%% A check on the angle to ensure it is less than the 20 degree
%  specified ejection angle
    if theta > pi/9
        theta = pi/9;
    end
%% The minimum and maximum x values contained in the surface of
%  intersection between the cylindrical beam and the spherical
%  wavefront section
    minx = -d*sin(theta);
    maxx = d*sin(theta);
%% A numerical integration to calculate the total surface area of
%  the intersection surface through a double integral that has been
%  simplified to a single integral by performing one fo the integrals
%  already
    %% The step size for the numerical integral
        dx = (maxx - minx)/100.0;
    %% The updating value of the total area of the surface of
    %  intersection
        hit = 0.0;
    for x=minx:dx:maxx
        %% Calculating the minimum and maximum y-values at a given
        %  x value in the surface of intersection in order to make
        %  the calculation into a one-dimensional integral
            miny = (A - x^2.0)/(2*B);
            z = sqrt(d^2.0 - miny^2.0 - x^2.0);
            beta = asin(z/d);
            maxy = miny + d*(1-cos(beta));
        %% Checks on the maximum y value, which should not go beyond
        %  the furthest edge of the beam nor should the total y
        %  distance covered between the start and end of the
        %  intersecting surface exceed the diameter of the beam
            if maxy > (D + 2.0*R)
                maxy = D + 2.0*R;
            end
            if maxy > (miny + 2.0*R)
                maxy = miny + 2.0*R;
            end
        %% Updating the total surface area of the surface of
        %  intersection
        dhit1 = d*atan(maxy/sqrt(d^2.0-x^2.0-maxy^2.0));
        dhit2 = d*atan(miny/sqrt(d^2.0-x^2.0-miny^2.0));
        dhit = (dhit1 - dhit2)*dx;
        hit = hit + abs(dhit);
    end
%% Calculating the ratio of the area of the intersection surface to
%  the total surface area of the section of the spherical cone
%  wavefront that we are considering
    zeta = abs(hit/area);
%% A check on the ratio.  It should not exceed one, which may be
%  possible due to the numerical integration
    if zeta > 1.0
        zeta = 1.0;
    end
end