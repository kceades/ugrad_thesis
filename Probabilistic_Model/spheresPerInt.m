function [prob] = spheresPerInt(v1, v2)
%% This function returns the total probability density of a sphere
% having a velocity between v1 and v2 for a Boltzmann distribution
% with an expected value of V for the velocity
%% The one parameter that can be changed, the expected or mean value
%  for the velocity of the spheres
    V = 8.3;
%% The two constants for the Maxwell-Boltzmann distribution
    A = sqrt((1.0/(pi*V^2.0))^3.0)*4.0*pi;
    B = -1.0/(V^2.0);
%% A numerical integrator, once again following a simple Riemann
%  summation technique with a left-hand sum approach
prob = 0.0;
delta = (v2 - v1)/100.0;
while v1 < v2
    prob = prob + A*v1^2.0*exp(v1^2.0*B)*delta;
    v1 = v1 + delta;
end
end