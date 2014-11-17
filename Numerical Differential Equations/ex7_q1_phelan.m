%4th Order Runge Kutta method for numerically evaluating first order
%differential equations. Second order ODEs can be split into two first
%order ODEs for evaluation.

%ODE function is located in seperate ODE.m file in same folder.

%recommended settings are .0001 for time step, .01 for theta step.

%By: Russell Phelan 11/7/14 for Computational Physics 281 at UMass Amherst

clear all;
clear figure;

step = input('Input step size in seconds: ');
thetaStep = input('Input angle step size in radians: ');
%theta0 = input('Input initial angle from vertical in radians: ');


startInt = 0; %start of time interval
endInt = 10;  %end of time interval
totalSteps = (endInt-startInt)/step;

t0 = 0; %initial time value.
w0 = 0; %starting angular velocity

thetas = [];
periods = [];



for theta0 = .0001:thetaStep:pi/2
    
    %setting variables for next angle pendulum emulation
    oldTheta = theta0; %sets initial theta at next angle in loop
    oldOmega = w0; %sets intial ang vel to rest
    oldT = t0; %sets t to 0
    nextTheta = 0; %blank values for next iterations
    nextOmega = 0;
    nextT = 0;
    omegas = w0; %starting values for collection vectors
    ts = t0;
    
    
    %resetting k values for next iteration
    k1t = 0;
    k2t = 0;
    k3t = 0;
    k4t = 0;
    k1w = 0;
    k2w = 0;
    k3w = 0;
    k4w = 0;
    
    thetas = [thetas theta0]; %adds next angle in loop to angle vector
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
        
        %storing next values in vectors
        ts = [ts nextT];
        %omegas = [omegas nextOmega];
        %thetas = [thetas nextTheta];
        
        %check for sign change in omega
        if(oldOmega*nextOmega < 0)
            break;
        end
        
        oldTheta = nextTheta;
        oldOmega = nextOmega;
        oldT = nextT;
        
    end
    
    
    %new period estimator
    period = ts(end) - ts(1);
    periods = [periods period*2];
end

%analytic period estimator for small angle solution
g = 9.8; %in m/s^2
l = 2; %in m
anPeriod = 2*pi*sqrt(l/g);
anPeriods = [];

for it=1:length(thetas)
    anPeriods(it) = anPeriod;
end

%chi-square fitting method

x = thetas;     % 1st data column is x 
y = periods;     % 2nd data column is y

%filling in uncertainties
for it=1:length(thetas)
    sigma(it) = .01;
end

N=length(x);         % number of data points


% now do quadratic fit using design matrix technique 

M = 5;          % number of parameters for a quadratic fit
A = zeros(N,M); % prepare design matrix
b = zeros(N,1);

% fill (NxM) design matrix A and (Nx1) column vector b

for i=1:N
    for j=1:M
        A(i,j)=(x(i)^(j-1))/sigma(i);
    end
    b(i,1) = y(i)/sigma(i);
end

% now solve for parameters a and plot
a = (A'*A) \ (A'*b);     % works better than a=inv(A'*A)*(A'*b) 
y_prediction = a(1) + a(2)*x + a(3)*x.^2 + a(4)*x.^3 + a(5)*x.^4;


%plotting period graphs
subplot(2,1,1);
plot(thetas,periods);
hold on;
plot(thetas,anPeriods,'-g');
title('Period vs. Initial Theta');
xlabel('Initial Theta (rads)');
ylabel('Period (s)');
legend('Runge Kutta','Small Ang');

subplot(2,1,2);
hold on
plot(x,y,'b.');
plot(x,y_prediction,'r');
legend('Data','Fit');
title('Period vs. Initial Theta');
xlabel('Initial Theta (rads)');
ylabel('Period (s)');
hold off


fprintf('Found fit parameters a(1)=%f\n a(2)=%f\n a(3)=%f\n a(4)=%f\n a(5)=%f\n',a(1),a(2),a(3),a(4),a(5));


%the fit parameters were found by using the design matrix technique of
%chi-square fitting. This works for any function with linear fit
%parameters. 
 

 
%THE FOLLOWING CODE IS ALL FOR TESTING THE PENDULUM SIMULATION IE TO SEE IF IT CONSERVES ENERGY 
 

%plotting small angle analytic solution for comparison
%  g = 9.8; %in m/s^2
%  l = 2; %in m
%  t = 0:step:endInt;
%  thetaT = theta0*cos(t*sqrt(g/l));
%  omegaT =-1*sqrt(g/l)*theta0*sin(t*sqrt(g/l));

%energy calculations
% m = 1; %mass in kg
% 
% kineticEKutta = (1/2)*m*(omegas*l).^2; %kinetic energy formula
% potentialEKutta = m*g*l*(1-cos(thetas)); %potential energy formula
% totalEKutta = kineticEKutta + potentialEKutta; %total energy
% 
% kineticESmall = (1/2)*m*(omegaT*l).^2; %kinetic energy formula
% potentialESmall = m*g*l*(1-cos(thetaT)); %potential energy formula
% totalESmall = kineticESmall + potentialESmall; %total energy

 %plotting displacement vs. time
%  subplot(2,1,1);
%  plot(ts,thetas,'r');
%  hold on;
%  %plot(t,thetaT,'g');
%  xlabel('Time (s)');
%  ylabel('Displacement (rads)')
%  title('Displacement vs. Time');
%  legend('Kutta','Small-Angle');
%  hold off;
%  subplot (2,1,2);
%  plot(ts,omegas);
% 
% %energy plots for Kutta Method
% subplot(3,1,2);
% plot(ts,kineticEKutta,'r');
% xlabel('Time (s)');
% ylabel('Energy (J)');
% hold on;
% plot(ts,totalEKutta,'b');
% xlabel('Time (s)');
% ylabel('Energy (J)');
% hold on;
% plot(ts,potentialEKutta,'g');
% xlabel('Time (s)');
% ylabel('Energy (J)');
% title('Energy vs. Time for Kutta Method');
% legend('Kinetic','Total','Potential');
% 
% %energy plots for Small Angle Method
% subplot(3,1,3);
% plot(t,kineticESmall,'r');
% xlabel('Time (s)');
% ylabel('Energy (J)');
% hold on;
% plot(t,totalESmall,'b');
% xlabel('Time (s)');
% ylabel('Energy (J)');
% hold on;
% plot(t,potentialESmall,'g');
% xlabel('Time (s)');
% ylabel('Energy (J)');
% title('Energy vs. Time for Small Angle Approx');
% legend('Kinetic','Total','Potential')
