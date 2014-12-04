%Conduction of heat along a 1-D Copper Rod. Displays 3D mesh plot showing
%Temperature as a function of time, and position on the rod. 
%By: Russell J Phelan, UMass Amherst 12/4/14 for Computational Physics 281

%i is index along length of rod. j is index of time since heat was allowed
%to start flowing. 
clear all; 

%constants
a = 1.1234*10^(-4); %m^2/s

dt = 10; %in seconds
dx = .05; %in meters
L = 1; %in meters
time = 2000; %in seconds
initTemp = 1000; %in degrees Kelvin

xN = L/dx;
tN = time/dt;

u = zeros(xN+1,tN+1); %will store temperature, position, and time

u(1,1:tN) = initTemp; %sets left end of rod at initial temperature

 for j = 1:tN-1
     
     for i = 2:xN-1
         
     %difference equation
     u(i,j+1) = u(i,j) + dt*a*((u(i+1,j)-2*u(i,j)+u(i-1,j))/(dx^2));
     
     end
 end
 
 ts = 0:dt:time;
 xs = 0:dx:L;
 
 mesh(ts,xs,u);
 zlabel('Temperature (K)');
 xlabel('Time (s)');
 ylabel('Position (m)');
 title('Temperature as a function of Position and Time');
 