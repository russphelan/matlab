%Numerical approximation of intergrals by rectangle rule, using either
%right or left end points. 

%By: Russell J Phelan, 10/26/14 for Computational Physics 281 at UMass
%Amherst

clear all;

%Global Parameters 
f = inline('x^2'); %function to approximate intergral of
numInts = 4; %number of interval to divide area under curve into
startInt = 0; %value to start interval of intergration at
endInt = 5; %value to end interval of intergration at
leftEndPoints = 0; %Switches to left endpoints, uses right endpoints by default. 

dx = (endInt-startInt)/numInts;

for i=0:numInts
    y = f(startInt + dx*numInts);
    areaSoFar = areaSoFar + y*dx;
end

areaSoFar
