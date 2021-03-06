%Models Lotka-Volterra Predator-Prey equations. System of coupled equations
%that shows growth of both predator and prey populations when in the same
%environment. a,b,c,d in derivatives function control charactaristics of
%population. Initial conditions are set in this file. 

%By: Russell J Phelan 12/6/14 UMass Amherst for Computational Physics 281

clear all;

sw = input('Choose conditions.\n 1=given\n 2=stable\n 3=fluctuating\n');

%global settings
dt=0.0001;
t=0:dt:10;
N=length(t);

prey=zeros(1,N);
pred=zeros(1,N);

%sets initial conditions
switch sw
    case 1 %Given
        prey(1)=70; 
        pred(1)=70;
    case 2 %Stable
        prey(1)=100; 
        pred(1)=99.99999999; 
    otherwise
        prey(1)=70;
        pred(1)=70;
end

%Runge-Kutta algorithm
s = [prey(1) pred(1)];
for i=2:N
    s1 = s;
    
    k1 = derivatives(s1,sw);
    s2 = s1 + k1 * dt/2.0;
    
    k2 = derivatives(s2,sw);
    s3 = s1 + k2 * dt/2.0;
  
    k3 = derivatives(s3,sw);
    s4 = s1 + k3 * dt/1.0;
    
    k4 = derivatives(s4,sw);
    s = s1 + (dt/6.0)*(k1+2.0*k2+2.0*k3+k4); %RK4 step
    
    prey(i)=s(1);
    pred(i)=s(2);
end

%plotting results
subplot(2,1,1)
plot(prey,pred);
xlabel('Number of Prey'); 
ylabel('Number of Predators'); 
legend('Prey vs. Predators');

subplot(2,1,2)
plot(t,prey,'b'); 
hold on;
plot(t,pred,'r');
hold off; 
xlabel('Time'); 
ylabel('Population'); 
legend('Prey','Predators');

%QUESTIONS
%Q1: Considering equal starting conditions of predators and prey, raising the 
%initial population number moves towards a more circular limit cycle. The range
%of populations also decrease. 

%Q2: The plots react more to the parameters of the ODEs than to the initial
%conditions. This makes sense, because changes to parameters affect each
%iteration, and in a way, are compounded. 

%Q3: From the equations, we can see that parameters that make the
%derivatives = 0 will cause equilibrium.  Solving the equations for roots
%with the given parameters, we find that initial conditions of 100
%predators, and 99.9999 prey will give a stable population. Indeed, there
%is very little variation in the simulation at theses values. 

%Q4: Parameters 'a' and 'd' are the regular growth rates of the population,
%not considering predation. 'c' and 'e' determine how often predators and
%prey meet, which affects amount of predation. This is why these terms
%involve both x and y. The last parameter 'b' determines the carrying
%capacity of the environment for the prey, and how long it takes for the
%prey to reach this capacity without predation. 

%Q6: We could use the 'floor' and 'ceil' functions to force all values
%taken throughout the program to be integers. 