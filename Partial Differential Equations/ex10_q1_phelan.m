%heat conduction on a 2D sheet. Starts with boundary conditions, shows
%final temperature values at all points on sheet. 

%By: Russell J Phelan, 12/4/14 UMass Amherst for Computational Physics 281

clear all;

dt = 0.01;
dx = 0.01;
dy = 0.01;
t  = 0:dt:100;
x  = 0:dx:1;
y  = 0:dy:1;

%sizes of matrices
tN = length(t);
xN = length(x);
yN = length(y);

T = zeros(xN,yN);

%initial conditions

T(xN,1) = 50;
T(1,yN) = 100;
T(xN,yN) = 100;
T(1,1) = 50;

for i=2:yN-1
    T(i,1) = 0;
    T(i,yN) = 100;
    T(1,i) = 100;
    T(xN,i) = 100;
end


%finds temperature values at each point on sheet
for k=1:tN              
    for j=2:yN-1         % Y calculations
    
        for i=2:xN-1     % X calculations
            T(i,j) = 0.25*(T(i+1,j)+T(i-1,j)+T(i,j+1)+T(i,j-1));
        end
    
    end
    
    % Testing for convergence
    middlePointTemp(k) = T(50,50);
end

%calculating fractional change in temp for middle point
fractionalChange = zeros(1,length(middlePointTemp));
for(i=2:length(middlePointTemp))
    fractionalChange(i) = middlePointTemp(i)-middlePointTemp(i-1);
end

subplot(2,1,1)
plot(t,middlePointTemp);
xlabel('Time (s)'); ylabel('Temperature at Middle (K)');
legend('Temperature (K)');
title('Change in Temperature vs. Time for Middle Position (K)');

subplot(2,1,2)
plot(t,fractionalChange);
xlabel('Time (s)'); 
ylabel('Fractional Change in Temp at Middle');
legend('Fractional Change');
title('Fractional Change in Temperature vs. Time for Middle Position (Dimensionless)');

figure;
mesh(x,y,T);
zlabel('Temperature (K)');
xlabel('Position (m)');
ylabel('Position (m)');
title('Temperature vs. Position on 2-D Sheet (K)');

%Questions: 

%1. You can tell that the solution has converged when fractional change in
%temperature for the test point approaches 0. 

%2. The tighter the grid spacing is, the more iterations will be required
%for convergence. 

%3. The tighter the grid spacing is, the more accurate the model of
%temperature becomes. I used the tightest spacing I could without causing
%the model to take too long to converge. 
