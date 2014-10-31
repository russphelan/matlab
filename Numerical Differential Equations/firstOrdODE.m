function [yPrime] = firstOrdODE(t,y)
%a first order differential equation. takes ind variable t, and unknown
%function y, computer derivative of unknown function y.

g = 9.8; %in m/s^2, acceleration due to gravity.
b = .1; %N/(m/s), drag constant, depends on shape of object, and properties of fluid through which it is traveling. 
m = 1; %in kg. mass of falling object.

%falling object with air drag
yPrime = g-(b/m)*y;
end

