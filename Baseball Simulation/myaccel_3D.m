% function to compute acceleration given velocity

function a = myaccel_3D(v,Cd,rho,A,m,g,Dm,w)

vtemp = [v(1) v(2) v(3)];
vmag  = norm(vtemp);

magnus = m*Dm*cross(w,v);

Ftemp = [-0.5*Cd*rho*A*vmag*v(1) + magnus(1), -0.5*Cd*rho*A*vmag*v(2) + magnus(2), -0.5*Cd*rho*A*vmag*v(3) - m*g + magnus(3)];

%Ftemp = [0, 0, - m*g];

a = Ftemp/m;

return
