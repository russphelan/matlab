%straight line fitter and chi-square calculator for CO2 data. 

%Group Members: Russell Phelan, Phillip Rebrovic

clear all; close all;

mydata = load('co2_data.dat');    % read in (x,y,dy) data from text file 

x = mydata(:,3);     % 1st data column is x 
y = mydata(:,5);    % 2nd data column is y
%sigma = mydata(:,3); % 3rd data column is experimental uncertainty on y

N=length(x);         % number of data points

%filling in standard error
for n=1:N
    sigma(n) = .2;
end

% prepare straight line fit to date
% y = a(1) + a(2) * x;
% use matrices defined in Lecture 17 : Aa = b

A = zeros(2,2);
b = zeros(2,1);
for i=1:N
    A(1,1) = A(1,1) +         1/sigma(i)^2;
    A(1,2) = A(1,2) +      x(i)/sigma(i)^2;
    A(2,1) = A(2,1) +      x(i)/sigma(i)^2;
    A(2,2) = A(2,2) + x(i)*x(i)/sigma(i)^2;
    
    b(1,1) = b(1,1) + y(i)/sigma(i)^2;
    b(2,1) = b(2,1) + y(i)*x(i)/sigma(i)^2;
end

a  = A\b;     % a=vector of best fit parameter. 
              % A\b works better than using a=inv(A)*b
a1 = a(1,1);
a2 = a(2,1);
y_prediction = a1+a2*x;

%calculating chi-square
chiSquare = 0;
for z=1:N
    chiSquare = chiSquare + (((a2*x(z)+a1)-y(z))/sigma(z))^2;
end

chiSquare

degreesFreedom = N-2

hold on
errorbar(x,y,sigma,'bo');
plot(x,y_prediction,'r')
legend('Data','Fit');
xlabel('Decimal Year');
ylabel('Seasonally Averaged CO2 Levels (ppm)');
hold off

fprintf('Found intercept a(1)=%f, slope a(2)=%f\n',a(1),a(2));
return;

%Comments: 
%We know that a good fit is defined as approximately equal to v+-sqrt(2*v)
%which = 678+-36.82. We can see that our chi-square of 151,000 represents a
%very poor fit. 
