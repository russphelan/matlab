%4th Order Runge Kutta method for numerically evaluating first order
%differential equations. Second order ODEs can be split into two first
%order ODEs for evaluation. 

%ODE function is located in seperate ODE.m file in same folder. 

%By: Russell Phelan 11/7/14 for Computational Physics 281 at UMass Amherst

clear all; 

totalSteps = 10000;
startInt = 0; %start of time interval
endInt = 10;  %end of time interval
step = (endInt-startInt)/totalSteps; %called 'h' in Runge Kutta methods.
                                     %Increment size of independent variable, usually of time.
t0 = 0; %initial time value. 
theta0 = 1.5; %initial theta value in radians. 
w0 = 0; %starting angular velocity

%plotting small angle analytic solution for comparison
g = 9.8; %in m/s^2
l = 2; %in m
t = 0:step:endInt;
thetaT = theta0*cos(t*sqrt(g/l));

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


%plot(ts,omegas);


 plot(ts,thetas,'r');
 hold on;
 plot(t,thetaT,'g');
    
    
    