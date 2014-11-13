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
xiter = 1;
xdecades = []

%fill array for next decade
for iter=1:5
    for xiter=1:length(x)
        if((x(xiter)>=(1960 + 10*(iter-1))) && x(xiter) < (1960 + 10*(iter)))
            xdecades(xiter,iter) = x(xiter);
        end
    end
end    
xdecades
            
slopes = [];
for matiter = 1:5
    
% prepare straight line fit to date
% y = a(1) + a(2) * x;
% use matrices defined in Lecture 17 : Aa = b

A = zeros(2,2);
b = zeros(2,1);
for i=1:size(xdecades)
    
    if xdecades(i,matiter) == 0
        continue;
    end
    
    A(1,1) = A(1,1) +         1/sigma(i)^2;
    A(1,2) = A(1,2) +      xdecades(i,matiter)/sigma(i)^2;
    A(2,1) = A(2,1) +      xdecades(i,matiter)/sigma(i)^2;
    A(2,2) = A(2,2) + xdecades(i,matiter)*xdecades(i,matiter)/sigma(i)^2;
    
    b(1,1) = b(1,1) + y(i)/sigma(i)^2;
    b(2,1) = b(2,1) + y(i)*xdecades(i,matiter)/sigma(i)^2;
end

a  = A\b;     % a=vector of best fit parameter. 
              % A\b works better than using a=inv(A)*b
a1 = a(1,1);
a2 = a(2,1);
y_prediction = a1+a2*x;

slopes = [slopes a2];


end

decadesPlot = [1960 1970 1980 1990 2000];

plot(decadesPlot,slopes,'Marker','+');
xlabel('Decade (years)');
ylabel('Slope (ppm/year)'); 
title('Slope vs. Decade');

