%Cannonball program by Russell J Phelan, Physics 281 Fall 2014
%This program plots the trajectory of a cannonball (particle) 

clear all %clears all previous variables 
close all %closes all open plots

%global variables
g = 9.8; %in m/s^2

v_0 = 50; %in m/s

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

targetHits = [];
hitsIndex = 1;
row = 1;
col=1;
hasHit = 0;

%tell user cannonball will be launched at v_0
%disp('Cannonball will be launched at 50m/s')
formatspec = 'Cannonball will be launched at %um/s\n';
fprintf(formatspec,v_0)

%main game loop
for thetaRad=0:.000001:(pi/2),
    %find initial velocity components
    v_0x = v_0 * cos(thetaRad);
    v_0y = v_0 * sin(thetaRad);

    %creating time vector
    t = t_0:t_inc:t_f;
x_0 = 0; %initial x position of cannonball

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

    %check if hit target. adds two different angle ranges to two columns of
    %a matrix
    if (xHit >= 140 && xHit <= 150)
        targetHits(row,col) = radtodeg(thetaRad);
        row = row + 1;
        hasHit = 1;
    else
        if (hasHit)
            col = 2;
        end
    end
    end

%getting max and min values from each column
maxs = max(targetHits);
targetHits(~targetHits) = inf;
mins = min(targetHits);

%printing final results
str = 'Angles that hit the target fall in two ranges: [%0.4f, %0.4f] and [%0.4f, %0.4f].';
sprintf(str,mins(1),maxs(1),mins(2),maxs(2))

%QUESTION: What affecs the precision of your result? 
%ANSWER: Mainly the increment of the angle in the main 'for' construct. If
%we evaluate whether we've hit the target for more angles closer together,
%we will have a more precise result. 

%The limiting factor is the amount of
%space/processing power available. The most inefficient operation is the
%adding of an element to the array. We are allocating a new array each
%time. Instead, we could either pre-allocate a huge block of memory, or
%use a reference-based structure like a linked list with a more effecient
%'add' operation. This would allow us to use a smaller angle increment, and
%increase precision. 