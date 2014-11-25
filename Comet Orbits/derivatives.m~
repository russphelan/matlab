% function to compute acceleration given distance from Sun, and mass of Sun. Uses Newton's
% Universal Law of Gravity 
%s and sNew are state vectors representing the position and velocity of the
%earth with respect to the Sun. 

function k1 = derivatives(s)

G = 6.67384e-11; %Newton's gravitational constant
Msun = 1.989e30; %mass of Sun in kg

r = [s(1) s(2) s(3)];
v = [s(4) s(5) s(6)];

%calculating accelerations
rtemp = [r(1) r(2) r(3)];
rmag  = norm(rtemp);

k1 = [v(1), v(2), v(3), ((-G*Msun)/(rmag^3))*r(1), ((-G*Msun)/(rmag^3))*r(2), ((-G*Msun)/(rmag^3))*r(3)]; 

return