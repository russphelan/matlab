%Numerical approximation of intergrals by rectangle rule, using either
%right or left end points. 

%By: Russell J Phelan, 10/26/14 for Computational Physics 281 at UMass
%Amherst

%f is function to integrate, start and endInt define interval of
%integration numInts is number of intervals to use, and rightEndPoints is a
%boolean that causes algo to use right end points. Left points are used by
%default. 

function area = rectangle_rule(startInt,endInt,numInts,rightEndPoints)

dx = (endInt-startInt)/numInts;
area = 0;

if(rightEndPoints)
    startInt = startInt + dx;
end

for i=0:(numInts-1)
    y = f(startInt + dx*i);
    area = area + y*dx;
end

end
