%returns final Runge-Kutta Order 4 step to be used in scripts for numerical
%differential equation approximation

function s = rk4(r,v,dt)

s = [r v];   % starting state vector, contains two vectors

s1 = s;
k1 = derivatives(s1);
s2 = s1 + k1 * dt/2.0;
k2 = derivatives(s2);
s3 = s1 + k2 * dt/2.0;
k3 = derivatives(s3);
s4 = s1 + k3 * dt/1.0;
k4 = derivatives(s4);
s = s1 + (dt/6.0)*(k1+2.0*k2+2.0*k3+k4);


end