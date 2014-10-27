%Numerical approximation of intergrals by Simpson's Rule

%By: Russell J Phelan, 10/26/14 for Computational Physics 281 at UMass
%Amherst

function area = simpsons_rule(startInt,endInt,numInts)

dx = (endInt-startInt)/numInts;
area = 0;

for i=0:(numInts-1)
    a = startInt + dx*i;
    b = startInt + dx*i + dx;
    
    area = area + ((b-a)/6)*(f(a) + 4*f((a+b)/2) + f(b));    
    
end

end