%Cannonball program by Russell J Phelan, Physics 281 Fall 2014
%This program plots the trajectory of a cannonball (particle) 

clear all %clears all previous variables 
close all %closes all open plots

%global variables
g = 9.8; %in m/s^2

v_0 = 20; %in m/s

%calculate total time necessary for trajectories to complete, using v_0
t_f = 0; %initial value
yAt90 = [-4.9 v_0 0];
rootsAt90 = roots(yAt90);
j = 1;
while (j <= 2)
    if (rootsAt90(j) > t_f)
        t_f = rootsAt90(j);
    else
        j = j + 1;
    end
end
t_0 = 0; %starting time in send
t_inc = .1; %time increment in s (must be small enough for good plot resolution)

x_0 = 0; %initial x position of cannonball
y_0 = 0; %initial y position of cannonball

%draw axes and target. Labels target
axis([0 50 0 50]);
xlabel('Distance (m)');
ylabel('Height (m)');
title('Cannonball Trajectory');

line([24 29],[1.5 1.5],'Color','red','LineWidth',1); %creating target
line([20 25],[3.2 3.2],'Color','red','LineWidth',1); %creating target

xArrow = [.81 .71]; %both in units normalized to figure. 0<x<1.
yArrow = [.2 .11];  %
annotation('arrow',xArrow,yArrow); %draws arrow to target, with 'Target' label
text(170,20,'Target');

%tell user cannonball will be launched at v_0
%disp('Cannonball will be launched at 50m/s')
formatspec = 'Cannonball will be launched at %um/s\n';
fprintf(formatspec,v_0)

%main game loop
for i=1:5,
    %ask user the launch angle, in degrees
    thetaDeg = input('enter launch angle in degrees above the horizontal (greater than 0): \n angle = ');
    thetaRad = degtorad(thetaDeg); %converting to radians

    %find initial velocity components
    v_0x = v_0 * cos(thetaRad);
    v_0y = v_0 * sin(thetaRad);


    %creating time vector
    t = t_0:t_inc:t_f;

    %creating position vectors
    xPos = x_0 + v_0x*t; %no acceleration, ignoring air resistance
    yPos = y_0 + v_0y*t + (1/2)*(-g)*t.^2;

    %finding where cannonball will land
    root1 = (-v_0y + sqrt(v_0y^2 + 2*g*y_0))/(-g);%Together, these are the quadratic formula
    root2 = (-v_0y - sqrt(v_0y^2 + 2*g*y_0))/(-g);% 
    if (root1 > root2) %determines which root is greater; this is time when cannonball lands
        greaterRoot = root1;
    else
        greaterRoot = root2;
    end
    xHit = x_0 + v_0x*greaterRoot; %finds x position where cannonball hits ground

    %plotting trajectory
    hold on; %adds new trajectories to old plot
    plot(xPos,yPos)

    %check/tell user whether cannonball hit target
    if (xHit >= 140 && xHit <= 150)
        disp('You hit the target')
    else
        disp('You missed the target')
    end
end