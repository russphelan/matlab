%Numerical approximation of intergrals by trapazoid rule. 

%By: Russell J Phelan, 10/26/14 for Computational Physics 281 at UMass
%Amherst. 

function area = trapezoid_rule(startInt,endInt,numInts)

dx = (endInt-startInt)/numInts;
area = 0;

for i=0:(numInts-1)
    y_1 = f(startInt + dx*i); %left point
    y_2 = f(startInt + dx*i + dx); %right point
    
    %checks which y is bigger, adds trapezoid to area based on that check
    if y_2<y_1
         area = area + y_2*dx + (y_1-y_2)*dx*(1/2);
    elseif y_2>y_1
        area = area + y_1*dx + (y_2-y_1)*dx*(1/2);
    elseif y_2==y_1
        area = area + y_1*dx;
    end
    
end

end

