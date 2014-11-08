function [wP] = omegaP(t, theta)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

l = 2; %in meters, length of pendulum
g = 9.8; %in m/s^2, acceleration of gravity


wP = (-g/l)*sin(theta);

end

