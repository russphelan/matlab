% example of vectorization of RK2 for projectile motion of baseball
% including drag in 3D

clear all; close all;

x0AU = input('Please enter initial x position in AU: ');
vy0AUyear = input('Please enter initial y velocity in AU/Year: ');
%vx0AUyear = input('Please enter initial x velocity in AU/Year: ');

years = input('Please enter number of years for which to run the simulation: ');

AU = 1.495978707e11; %length of AU in meters
Mearth = 5.972e24; %mass of Earth in kg
Msun = 1.989e30; %mass of Sun in kg
G = 6.67384e-11; %Newton's Gravitational constant
seconds = years*3.15569e7; %converting years to seconds
dt = seconds/10000; %breaking year up into steps
plotevery = 60; %plot every x elements in the plot, so we can still have accuracy of many steps, but not have a crowded plot

x0 = x0AU*AU;   y0 = 0;  z0 = 0;  % set initial position at origin in feet
vx0 = 0; vy0 = vy0AUyear*AU/365/24/60/60; vz0 = 0; % set initial velocity in m/s

r = [x0 y0 z0];            % make position row vector
v = [vx0 vy0 vz0];         % make velocity row

t  = 0:dt:seconds;         % vector of times
N  = length(t);            % number of time steps

rkeep = zeros(N,3);        % store baseball positions in this Nx2 array
% where first column has x position versus time
% second column has y position versus time
% t hird colum has z pos versus time
vkeep = zeros(N,3);
tkeep = zeros(N,1);

for i=1:N
    
    s2 = rk4(r,v,dt);
    
    r = [s2(1) s2(2) s2(3)];
    v = [s2(4) s2(5) s2(6)];
    
    rkeep(i,:)=r;    % now store the position vector for plotting
    vkeep(i,:)=v;
    tkeep(i) = dt*i;
    
end


%POSITION PLOT
rkeepAU = rkeep / 149597870700; %converting r vector into units of AU for plot
%plots every x elements, as defined by plotevery at top of program
scatter3(rkeepAU(1:plotevery:end,1),rkeepAU(1:plotevery:end,2),rkeepAU(1:plotevery:end,3));
hold on;
%plots Sun at origin in red
scatter3(0,0,0,'r');
hold off;
%labeling
axis([-2 2 -2 2 -2 2]);
xlabel('Distance (AU)');
ylabel('Distance (AU)');
zlabel('Distance (AU)');
title('Position of Earth in AU w.r.t Sun');
view(120,20);

%ENERGY PLOT
%calculating kinetic energy
vmags = zeros(length(vkeep),1); %preallocating vector
for i=1:length(vkeep)
    vmags(i)=norm(vkeep(i,:));
end

KE = (1/2)*Mearth*vmags.^2;

%calculating potential energy
rmags = zeros(length(rkeep),1); %preallocating vector
for i=1:length(rkeep)
    rmags(i)=norm(rkeep(i,:));
end

PE = -G*Mearth*Msun./rmags;

totalE = PE + KE;

figure; 
plot(tkeep/60/60/24,KE,'r'); %plots KE in red
hold on;
plot(tkeep/60/60/24,PE,'b');
hold on;
plot(tkeep/60/60/24,totalE,'g');


xlabel('Time (days)');
ylabel('Energy (Joules)');
title('Kinetic, Potential, and Total Energy vs. Time');





%MOMENTUM PLOT

return;