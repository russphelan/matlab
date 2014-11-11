%4th Order Runge Kutta method for numerically evaluating first order
%differential equations. Second order ODEs can be split into two first
%order ODEs for evaluation. 

%ODE function is located in seperate ODE.m file in same folder. 

%By: Russell Phelan 11/7/14 for Computational Physics 281 at UMass Amherst

clear all; 
clear figure;

step = input('Input step size in seconds: ');
theta0 = input('Input initial angle from vertical in radians: ');


startInt = 0; %start of time interval
endInt = 10;  %end of time interval
totalSteps = (endInt-startInt)/step;

t0 = 0; %initial time value. 
%theta0 = 1.5; %initial theta value in radians. currently taken from user
w0 = 0; %starting angular velocity

%runge kutta method for second order ODE solutions
oldTheta = theta0;
oldOmega = w0;
oldT = t0;
nextTheta = 0;
nextOmega = 0;
nextT = 0;
k1t = 0;
k2t = 0;
k3t = 0;
k4t = 0;
k1w = 0;
k2w = 0;
k3w = 0;
k4w = 0;

thetas = theta0;
ts= t0;
omegas = w0;

for i=1:totalSteps
    
    k1w = omegaP(oldT,oldTheta);
    k2w = omegaP(oldT + step/2,oldTheta + (step/2)*k1w);
    k3w = omegaP(oldT + step/2,oldTheta + (step/2)*k2w);
    k4w = omegaP(oldT + step,oldTheta + step*k3w);
    
    k1t = thetaP(oldT,oldOmega);
    k2t = thetaP(oldT + step/2,oldOmega + (step/2)*k1t);
    k3t = thetaP(oldT + step/2,oldOmega + (step/2)*k2t);
    k4t = thetaP(oldT + step,oldOmega + step*k3t);
   
    nextT = oldT + step;
    nextOmega = oldOmega + (step/6)*(k1w + 2*k2w + 2*k3w + k4w);
    nextTheta = oldTheta + (step/6)*(k1t + 2*k2t + 2*k3t + k4t);
   
    thetas = [thetas nextTheta];
    omegas = [omegas nextOmega];
    ts = [ts nextT];
    
    oldTheta = nextTheta;
    oldOmega = nextOmega;
    oldT = nextT;
    
end

%plotting small angle analytic solution for comparison
g = 9.8; %in m/s^2
l = 2; %in m
t = 0:step:endInt;
thetaT = theta0*cos(t*sqrt(g/l));
omegaT =-1*sqrt(g/l)*theta0*sin(t*sqrt(g/l));

%energy calculations
m = 1; %mass in kg

kineticEKutta = (1/2)*m*(omegas*l).^2; %kinetic energy formula
potentialEKutta = m*g*l*(1-cos(thetas)); %potential energy formula
totalEKutta = kineticEKutta + potentialEKutta; %total energy

kineticESmall = (1/2)*m*(omegaT*l).^2; %kinetic energy formula
potentialESmall = m*g*l*(1-cos(thetaT)); %potential energy formula
totalESmall = kineticESmall + potentialESmall; %total energy

%plotting displacement vs. time
subplot(3,1,1);
plot(ts,thetas,'r');
hold on;
plot(t,thetaT,'g');
xlabel('Time (s)');
ylabel('Displacement (rads)')
title('Displacement vs. Time');
legend('Kutta','Small-Angle');

%energy plots for Kutta Method
subplot(3,1,2);
plot(ts,kineticEKutta,'r');
xlabel('Time (s)');
ylabel('Energy (J)');
hold on;
plot(ts,totalEKutta,'b');
xlabel('Time (s)');
ylabel('Energy (J)');
hold on;
plot(ts,potentialEKutta,'g');
xlabel('Time (s)');
ylabel('Energy (J)');
title('Energy vs. Time for Kutta Method');
legend('Kinetic','Total','Potential');

%energy plots for Small Angle Method
subplot(3,1,3);
plot(t,kineticESmall,'r');
xlabel('Time (s)');
ylabel('Energy (J)');
hold on;
plot(t,totalESmall,'b');
xlabel('Time (s)');
ylabel('Energy (J)');
hold on;
plot(t,potentialESmall,'g');
xlabel('Time (s)');
ylabel('Energy (J)');
title('Energy vs. Time for Small Angle Approx');
legend('Kinetic','Total','Potential')

    
    