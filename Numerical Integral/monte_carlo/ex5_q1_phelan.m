%algorithm to evaluate area under a curve using Monte Carlo method. 
%By: Russell J Phelan, 10/31/14 for Computational Physics 182, UMass
%Amherst

%Function defined in f.m in same folder. Function needs to operate on
%vectors. Only works for functions where f(x) >= 0 on [startInt, endInt].

%also determines rate of of growth of error as N increases. 

clear all; 

startInt = 0; %defines interval on which to integrate
endInt = 5;
small = .000001; %precision of discretized increments
N = 100000; %number of random points used
analyticAns = (5+sin(15))/3; %for x^2, [0,4]

%calculate max of function on given interval 
x = startInt:small:endInt;
y = f(x);
max = max(y); %max of function on given interval

%generate random points, check if they are under curve or not. Keep track
%of changes in fractional error vs. analytic value for later plot. 
hits = 0;
misses = 0;
pts = [];
error = [];
for n=1:N
    pt = unifrnd([startInt,0],[endInt,max]); %generate random points in rectangle of height max, width endInt-startInt
    if pt(2) <= f(pt(1)) %if point is on or below the curve
        hits = hits + 1;
    else %point is above curve
        misses = misses + 1;
    end
    
    fractionalArea = hits/N; %ratio of area under curve to area above curve, bounded by rectangle.
    totalArea = endInt*max; %rectangle we are generating points in
    areaUnderCurve = totalArea*fractionalArea;
    
    error = [error abs(areaUnderCurve-analyticAns)/analyticAns];
end

%plot showing dependence of fractional error on N
nVals = 1:N;
plot(nVals, error.*nVals.^(1/2))
axis([0 10e4 -10e3 10e3]);
%title('$\epsilon\sqrt{N} vs.$','Interpreter','latex','FontSize',30)
xlabel('N','Interpreter','latex','FontSize',20);
ylabel('$\epsilon\sqrt{N}$','Interpreter','latex','FontSize',20);

%output telling user area under curve 
outString = 'the area under the curve is %f. The plot shows that fractional error decreases according to 1/sqrt(N).';
sprintf(outString,areaUnderCurve)

%It can be shown that the error decreases according to 1/sqrt(N) by
%calculating the sample variance, and taking the square root of the
%variance. This gives the standard error, which by analytical solution is
%equal to 1/sqrt(N)