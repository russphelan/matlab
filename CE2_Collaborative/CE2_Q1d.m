% general_fitter.m
% code which fits a polynomial to some data (x,y)

clear all; close all;

mydata = load('co2_data.dat');     % read in (x,y,dy) data from text file 

x = mydata(:,3);     % 1st data column is x 
y = mydata(:,4);     % 2nd data column is y
N=length(x);         % number of data points

%filling in standard error array, since error is same for every point
for n=1:N
    sigma(n) = .2;
end

%determining best phi for lowest chi-square value
M = 3;          % number of parameters for a quadratic fit
A = zeros(N,M); % prepare design matrix
b = zeros(N,1);
chiSquares = [];
phis = [];

% fill (NxM) design matrix A and (Nx1) column vector b
for phi=0:.1:pi
    for i=1:N
        for j=1:M
            A(i,j)=(x(i)^(j-1))/sigma(i);
        end
        A(i,4) = (sin(2*pi*x(i) + phi))/sigma(i);
        b(i,1) = y(i)/sigma(i);
    end
    % now solve for parameters a
    a = (A'*A) \ (A'*b);     % works better than a=inv(A'*A)*(A'*b)
    
    %calculating chi-square, checks goodness of fit
    chiSquare = 0;
    for z=1:length(x)
        chiSquare = chiSquare + (((a(3)*x(z)^2 + a(2)*x(z)+a(1) + a(4)*sin(2*pi*x(z)+phi))-y(z))/sigma(z))^2;
    end
    
    %storing results, goodness of fit for each phi, and corresponding phi
    %value
    chiSquares = [chiSquares chiSquare];
    phis = [phis phi];
end

%finding phi value that gives lowest chi-square, and storing it
[min minInd] = min(chiSquares);
bestPhi = phis(minInd);

%fit with sin, using best phi value
M = 3;          % number of parameters for a quadratic fit
A = zeros(N,M); % prepare design matrix
b = zeros(N,1);

% fill (NxM) design matrix A and (Nx1) column vector b

for i=1:N
    for j=1:M
        A(i,j)=(x(i)^(j-1))/sigma(i);
    end
    A(i,4) = (sin(2*pi*x(i) + bestPhi))/sigma(i);
    b(i,1) = y(i)/sigma(i);
end

% now solve for parameters a and plot
a = (A'*A) \ (A'*b);     % works better than a=inv(A'*A)*(A'*b) 
y_prediction = a(1) + a(2)*x + a(3)*x.*x + a(4)*sin(2*pi*x + bestPhi);

%calculating chi-square, checks goodness of fit
chiSquare = 0;
for z=1:length(x)
    chiSquare = chiSquare + (((a(3)*x(z)^2 + a(2)*x(z) + a(1) + a(4)*sin(2*pi*x(z)+bestPhi))-y(z))/sigma(z))^2;
end

chiSquare

subplot(2,1,1);
hold on
plot(x,y);
plot(x,y_prediction,'r');
legend('Data','Fit');
title('CO2 Concentration vs. Decimal Year');
xlabel('Decimal Year');
ylabel('CO2 Concentration (ppm)');
text(1960,390,'Degrees of Freedom = 676');
hold off

subplot(2,1,2);
plot(phis,chiSquares);
xlabel('Phi (radians)');
ylabel('Chi-Square of Oscillating Quad Fit');
title('Chi-Square of Oscillating Quad Fit vs. Phi');
annotation('arrow',[.8 .75], [.2 .125]);
text(3,3.70*10^4,'Best phi value');


fprintf('Found fit parameters\n a(1)=%f\n a(2)=%f\n a(3)=%f\n a(4)=%f\n phi=%f\n omega=2pi\n',a(1),a(2),a(3),a(4),bestPhi);

%ANSWERS TO QUESTIONS
%1. We would expect Chi-Square = v+-sqrt(2*v) for a good fit. This is an
%approx equals. This is 680+-36.9 in our case. 

%2. Our Chi-Square is of the order 10^4. This indicates that while our fit
%isn't terrible, it is not considered "good" either. This is in large part
%because the assumed uncertainty on each data point is so small. 
%Increasing the uncertainty to .9 ppm gives us a Chi-Square within bounds. 

%3. Our value for a4 is -2.816. This is the amplitude of yearly oscillation
%in CO2 concentration. 

%4. It appears that concentrations are highest in the summer, and dip to a low just
%before the new year, in the winter. 

%5. Based on our resulting fit function, we would estimate that CO2
%concentration levels in 2050 will be about 489.67 ppm. This is
%significantly higher than pre-industrial estimates. One possibility is
%that our increased dependence on industrial technology has caused humanity
%to pollute the atmosphere much faster than was previously predicted. 