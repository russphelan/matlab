% general_fitter.m
% code which fits a polynomial to some data (x,y)

clear all; close all;

mydata = load('mydata.txt');     % read in (x,y,dy) data from text file 

x = mydata(:,3);     % 1st data column is x 
y = mydata(:,4);     % 2nd data column is y
sigma = mydata(:,3); % 3rd data column is experimental uncertainty on y

N=length(x);         % number of data points


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

hold on
errorbar(x,y,sigma,'bo');
plot(x,y_prediction,'r');
legend('Data','Fit');
hold off

fprintf('Found fit parameters a(1)=%f a(2)=%f a(3)=%f\n',a(1),a(2),a(3));
