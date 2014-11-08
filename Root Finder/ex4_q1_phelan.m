%Root finder by Russell J Phelan, 10/24/14. Based on Bisection.m,
%distributed in class by David Kawall. 

%chooses x intervals 'inc' apart, searches each interval for a root by
%bisection, and checking for opposite signs. It's really slow, but it works. 
%Give it a chance to finish! 

clear all;

%global vars
small = 1.0e-9;	% stop when search domain in x for root smaller than this
startLo =0; %starting interval in which to search for roots
startHi=20;
inc = .01; %size of each tiny search interval
isRoot = 0; %boolean to mark whether there is a root in the curr interval
roots = []; %stores found roots

%inline function to find roots in 
f = inline('exp(-x/10)*cos(x^(2)/10)'); %'exp(-x/10)*cos(x^2/10)'

%loop to iterate through x intervals.
for i=startLo:inc:startHi
   
    xlo = i;
    xhi = i + inc;
    
    %checking for roots on boundaries of tiny intervals.
    if(((f(xhi)+eps)*f(xhi)-eps)<0)
        roots = [roots xhi];
    end
    
    while (abs(xhi-xlo) > small)   % still too far from root
        xmid = (xlo + xhi) / 2;
        ylo  = f( xlo);
        ymid = f( xmid);
        yhi  = f( xhi );
        
        if ( ymid*yhi < 0)  % root between xmid and xhi
            isRoot = 1;
            xlo =xmid;
        else
            xhi = xmid;      % root between xlo and xmid
        end
    end
    if(isRoot)
        roots=[roots xmid];
        isRoot=0;
    end
end

outRoots = unique(roots) %still returns 0 and -0 as roots due to nature of matlab unique func
