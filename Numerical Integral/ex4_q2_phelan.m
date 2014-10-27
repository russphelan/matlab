%Comparing numerical intergration methods. Varies number of intervals, and
%checks which algorithm meets a certain precision with the fewest
%intervals. 

%for collecting error information vs. N
rectError = [];
trapError = [];
simpError = [];

anAns =  5 + (sin(15)/3); %analytical answer to the intergral

for N=2:1000
    rectError = [rectError abs(rectangle_rule(0,5,N,0)-anAns)/anAns];
    trapError = [trapError abs(trapezoid_rule(0,5,N)-anAns)/anAns];
    simpError = [simpError abs(simpsons_rule(0,5,N)-anAns)/anAns];
    
end


Nvec = 2:1000;

figure
semilogy(Nvec,rectError,'r')
hold on;
semilogy(Nvec,trapError,'g')
hold on;
semilogy(Nvec,simpError,'b')

%output of answers to questions
sprintf('the RGB plot shows fractional error of the three algorithms on the same plot. \nred is rectangle, green is trapezoid, blue is simpsons. \nthis shows that simpsons rule has the smallest fractional error, and the rectangle rule has the largest') 

%finding rate of change of error for rectangle rule
figure

subplot(2,2,1);
plot(Nvec,rectError);
title('rectE');
subplot(2,2,2);
plot(Nvec,(rectError.*Nvec));
title('rectE*N');
subplot(2,2,3);
plot(Nvec,(rectError.*Nvec.^2));
title('rectE*N^{2}');
subplot(2,2,4);
plot(Nvec,(rectError.*Nvec.^3));
title('rectE*N^{3}');

%finding rate of change of error for trapezoid rule
figure

subplot(2,2,1);
plot(Nvec,trapError);
title('trapE');
subplot(2,2,2);
plot(Nvec,(trapError.*Nvec));
title('trapE*N');
subplot(2,2,3);
plot(Nvec,(trapError.*Nvec.^2));
title('trapE*N^{2}');
subplot(2,2,4);
plot(Nvec,(trapError.*Nvec.^3));
title('trapE*N^{3}');

%finding rate of change of error for simpson's rule
figure

subplot(3,2,1);
plot(Nvec,simpError);
title('simpE');
subplot(3,2,2);
plot(Nvec,(simpError.*Nvec));
title('simpE*N');
subplot(3,2,3);
plot(Nvec,(simpError.*Nvec.^2));
title('simpE*N^{2}');
subplot(3,2,4);
plot(Nvec,(simpError.*Nvec.^3));
title('simpE*N^{3}');
subplot(3,2,5);
plot(Nvec,(simpError.*Nvec.^4));
title('simpE*N^{4}');
subplot(3,2,6);
plot(Nvec,(simpError.*Nvec.^5));
title('simpE*N^{5}');

%output of answers to questions
sprintf('several compound plots are shown to illustrate the rate at which the fractional error shrinks vs. N. \nit can be seen from the plots that the rectangle rule error shrinks according to 1/N, \nthe trapezoid rule error according to 1/N^2, \nand simpsons rule error according to 1/N^4. \nthis is because these are the plots that show a flat graph, proving that our added factor of N^k is cancelling \nwith the rate of shrinkage, leaving a nearly constant function. \nthe plots are labeled with the algorithm they represent.')

sprintf('this shows that simpsons rule requires the smallest N value to reach a given precision. the rectangle rule requires the most.')


