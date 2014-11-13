% general_fitter.m
% code which fits a polynomial to some data (x,y)

clear all; close all;

mydata = load('co2_data.dat');     % read in (x,y,dy) data from text file 

x = mydata(:,3);     % 1st data column is x 
y = mydata(:,5);     % 2nd data column is y
N=length(x);         % number of data points

%filling in standard error
for n=1:N
    sigma(n) = .2;
end

% now do quadratic fit using design matrix technique 

M = 3;          % number of parameters for a quadratic fit
A = zeros(N,M); % prepare design matrix
b = zeros(N,1);

% fill (NxM) design matrix A and (Nx1) column vector b

for i=1:N
    for j=1:M
        A(i,j)=(x(i)^(j-1))/sigma(i);
    end
    b(i,1) = y(i)/sigma(i);
end

% now solve for parameters a and plot
a = (A'*A) \ (A'*b);     % works better than a=inv(A'*A)*(A'*b) 
y_prediction = a(1) + a(2)*x + a(3)*x.*x;

%calculating chi-square
chiSquare = 0;
for z=1:N
    chiSquare = chiSquare + (((a(3)*x(z)^2+a(2)*x(z)+a(1))-y(z))/sigma(z))^2;
end

chiSquare

degreesFreedom = N-3

hold on
errorbar(x,y,sigma,'bo');
plot(x,y_prediction,'r');
legend('Data','Fit');
text(1960,380,'Degrees of Freedom = 677');
hold off

fprintf('Found fit parameters a(1)=%f a(2)=%f a(3)=%f\n',a(1),a(2),a(3));

%This fit is much better. For a good fit, we know that our chi-square needs
%to be approximately equal to v+-sqrt(2*v). That means it should be
%approximately equal to 677+-36.79. Our chi-square for the quadratic fit is
%8,363, so we are much closer to our goal with the quadratic fit. 
