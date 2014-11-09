%Euler method for numerically evaluating second order
%differential equations. Second order ODEs can be split into two first
%order ODEs for evaluation. This script is used to compare the motion of
%the small-angle approximation of an ideal pendulum a Euler method
%approximation.

%By: Russell Phelan 11/9/14 for Computational Physics 281 at UMass Amherst

clear all;
clear figure;

step = input('Input step size in seconds: ');
theta0 = input('Input initial angle from vertical in radians: ');

startInt = 0; %start of time interval
endInt = 10;  %end of time interval
totalSteps = (endInt-startInt)/step;

t0 = 0; %initial time value in seconds.
%theta0 = 1; %initial theta value in radians.
w0 = 0; %starting angular velocity in rads/s

%Euler method for second order ODE solutions
oldTheta = theta0;
oldOmega = w0;
oldT = t0;
nextTheta = 0;
nextOmega = 0;
nextT = 0;

%initializing vectors
thetas = theta0;
omegas = w0;
ts= t0;

for i=1:totalSteps
    
    %time increments
    nextT = oldT + step;
    ts = [ts nextT];
    
    %increment Euler method
    nextOmega = oldOmega + step*omegaP(nextT,oldTheta);
    nextTheta = oldTheta + step*thetaP(nextT,oldOmega);
    
    %store next ODE results
    thetas = [thetas nextTheta];
    omegas = [omegas nextOmega];
    
    %iterate variables
    oldTheta = nextTheta;
    oldOmega = nextOmega;
    oldT = nextT;
    
end

%plotting small angle analytic solution for comparison
g = 9.8; %in m/s^2
l = 2; %in m
t = 0:step:endInt;
thetaT = theta0*cos(t*sqrt(g/l));

figure;
plot(ts,thetas,'r');
hold on;
plot(t,thetaT,'g');
title('Euler Method vs. Small Angle Approximation');
xlabel('Time (s)');
ylabel('Displacement (rads)');

%Comments: 
%
%Red is the Euler Method plot, green is the Small Angle plot. 
%When we use small intial angle, and small step sizes, like .0001, the
%graphs of the Euler Method output and the small angle approximation agree
%very well. 
%
%When larger step sizes are used, the Euler method graph increases in
%amplitude over time, and its agreement with the small angle solution gets
%worse as time goes on. 
%
%When we use a large intial theta, agreement between the two solutions is
%poor no matter how small the step size is chosen. 
%
%Note: program takes a while when run with time step .0001. I suggest .001m
%which still gives good results. 

    
    