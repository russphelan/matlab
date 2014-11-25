% function to compute acceleration given distance from Sun, and mass of Sun. Uses Newton's
% Universal Law of Gravity 

function a = newtonsGrav(G,Msun,r)

rtemp = [r(1) r(2) r(3)];
rmag  = norm(rtemp);

a = [((-G*Msun)/(rmag^3))*r(1), ((-G*Msun)/(rmag^3))*r(2), ((-G*Msun)/(rmag^3))*r(3)];

return