%Euler method for approximating first order differential equations. 

%By: Russell J Phelan, 10/31/14, for Computational Physics 281 at UMass
%Amherst

clear all;

steps = 1000;
t_0 = 0;
t_f = 100;
stepSize = (t_f-t_0)/steps; %this is sometimes called 'h' in the Euler Method
y_0 = 0; %initial condition of the differential equation



oldY = y_0;

ts = t_0;
ys = y_0;

%analytic results for comparison, using velocity and linear drag. This part
%will not be compatible if you change quadDrag.m. 
m = 1;
g = 9.8;
b = .1;
c = .01;

t = t_0:stepSize:t_f;

v = sqrt((g*m)/c)*tanh(sqrt(c*g/m)*t);

for n=1:steps
    nextT = t_0 + stepSize*n; %increment time by step size
    ts = [ts nextT]; %store time for plotting
    
    nextY = oldY + stepSize*quadDrag(nextT, oldY); %find new Y by Eulers Method
    ys = [ys nextY]; %store new Y solution point for plotting
    oldY = nextY; %store new Y solution to base next iteration off of
end

subplot(2,1,1);
plot(ts,ys,'o','MarkerSize',2);

hold on;
plot(t,v,'r');
title('Step Size = .1');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
hold on;



%second time through for plots with worse agreement, using assignment
%parameters
steps = 50;
t_0 = 0;
t_f = 100;
stepSize = (t_f-t_0)/steps; %this is sometimes called 'h' in the Euler Method
y_0 = 0; %initial condition of the differential equation



oldY = y_0;

ts = t_0;
ys = y_0;

%analytic results for comparison, using velocity and linear drag. This part
%will not be compatible if you change quadDrag.m. 
m = 1;
g = 9.8;
b = .1;
c = .01;

t = t_0:stepSize:t_f;

v = sqrt((g*m)/c)*tanh(sqrt(c*g/m)*t);

for n=1:steps
    nextT = t_0 + stepSize*n; %increment time by step size
    ts = [ts nextT]; %store time for plotting
    
    nextY = oldY + stepSize*quadDrag(nextT, oldY); %find new Y by Eulers Method
    ys = [ys nextY]; %store new Y solution point for plotting
    oldY = nextY; %store new Y solution to base next iteration off of
end

subplot(2,1,2);
plot(ts,ys,'o','MarkerSize',2);

hold on;
plot(t,v,'r');
title('Step Size = 2');
xlabel('Time (s)');
ylabel('Velocity (m/s)');



