% example of vectorization of RK2 for projectile motion of baseball 
% including drag

%clear all; close all;       
dt = input('Please enter the time step in seconds : ');

g  = 9.8;                 % acceleration due to gravity in m/s^2
m  = 0.145;                % baseball mass in kg
Cd = 0.29;                 % drag coefficient Cd
rho= 1.22;                 % density of air in kg/m^3
D  = 7.45/100.0;           % baseball diameter in m
R  = D/2;                  % baseball radius in m
A  = pi*(R^2);             % baseball cross-sectional area in m^2

 x0 = 0.0;   y0 = 0.0;  z0 = 0.0;  % set initial position at origin
vx0 = 25.0; vy0 = 25.0; vz0 = 50.0; % set initial velocity 

r = [x0 y0 z0];               % make position row vector
v = [vx0 vy0 vz0];             % make velocity row vector

t  = 0:dt:7;               % vector of times
N  = length(t);            % number of time steps

rkeep = zeros(N,3);        % store baseball positions in this Nx2 array
                           % where first column has x position versus time
                           % second column has y position versus time
                           % third colum has z pos versus time
                           
for i=1:N
   
   a = myaccel_3D(v,Cd,rho,A,m,g);  % find acceleration from current pos, vel
   
   vmid = v + a*dt/2;            % find velocity at midpoint
   amid = myaccel_3D(vmid,Cd,rho,A,m,g); % accel at midpoint depends on vmid
   
   r = r + vmid*dt;
   v = v + amid*dt;
   
   rkeep(i,:)=r;    % now store the position vector for plotting
   
end

stem3(rkeep(:,1),rkeep(:,2),rkeep(:,3),'LineWidth',.1);
view(45,50);

return;