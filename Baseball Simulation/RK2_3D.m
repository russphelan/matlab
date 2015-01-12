% example of vectorization of RK2 for projectile motion of baseball 
% including drag in 3D 

%clear all; close all;       
dt = input('Please enter the time step in seconds : ');
vx0f = input('Please enter initial x velocity in mph: ');
vy0f = input('Please enter initial y velocity in mph: ');
vz0f = input('Please enter initial z velocity in mph: ');
wHat = input('Please enter a unit vector in the direction of the axis of rotation using [x y z] notation: ');
freq = input('Please enter frequency of rotation in Hz: ');

g  = 9.8;                 % acceleration due to gravity in m/s^2
m  = 0.145;                % baseball mass in kg
Cd = 0.29;                 % drag coefficient Cd
rho= .9846;                 % density of air in kg/m^3
D  = 7.45/100.0;           % baseball diameter in m
R  = D/2;                  % baseball radius in m
A  = pi*(R^2);             % baseball cross-sectional area in m^2
Dm = .00065;               % coefficient for magnus force 

 x0 = 0;   y0 = -.6;  z0 = 2.1336;  % set initial position at origin in feet
vx0 = vx0f*.447; vy0 = vy0f*.447; vz0 = vz0f*.447; % set initial velocity in m/s
r = [x0 y0 z0];               % make position row vector
v = [vx0 vy0 vz0];             % make velocity row 
wMag = freq*2*pi;
w = wMag*wHat;

t  = 0:dt:5;               % vector of times
N  = length(t);            % number of time steps

rkeep = zeros(N,3);        % store baseball positions in this Nx2 array
                           % where first column has x position versus time
                           % second column has y position versus time
                           % t hird colum has z pos versus time
vkeep = zeros(N,3); 
tkeep = zeros(N,1);
for i=1:N
   
   a = myaccel_3D(v,Cd,rho,A,m,g,Dm,w);  % find acceleration from current pos, vel
   
   vmid = v + a*dt/2;            % find velocity at midpoint
   amid = myaccel_3D(vmid,Cd,rho,A,m,g,Dm,w); % accel at midpoint depends on vmid
   
   r = r + vmid*dt;
   v = v + amid*dt;
   
   rkeep(i,:)=r;    % now store the position vector for plotting
   vkeep(i,:)=v;
   tkeep(i) = dt*i;
   
end

%converting from meters to feet
rkeep = rkeep*3.2808;

vkeep = vkeep*2.2369;

stem3(rkeep(1:200:end,1),rkeep(1:200:end,2),rkeep(1:200:end,3),'LineWidth',.1);
axis([0 60 -5 5 0 8]);
view(120,20);
xlabel('Distance from Plate (ft)');
zlabel('Height of Pitcher (ft)');
ylabel('Width (ft)');

for i=1:length(rkeep)
if(rkeep(i) < 60)
    continue;
else
    break;
end
end

return;