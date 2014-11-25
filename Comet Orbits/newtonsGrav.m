% function to compute acceleration given distance from Sun, and mass of Sun. Uses Newton's
% Universal Law of Gravity 
%s and sNew are state vectors representing the position and velocity of the
%earth with respect to the Sun. 

function k1 = derivatives(s)
r = s(1);
v = s(2);

%calculating accelerations
rtemp = [r(1) r(2) r(3)];
rmag  = norm(rtemp);

k1 = [v(1), v(2), v(3), ((-G*Msun)/(rmag^3))*r(1), ((-G*Msun)/(rmag^3))*r(2), ((-G*Msun)/(rmag^3))*r(3)]; 

return