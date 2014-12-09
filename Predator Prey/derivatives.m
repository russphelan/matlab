function Derivs = derivatives(s,k)

switch k
    case 1 %given values
        a   = 10;
        b   = 10^(-5);
        c   = .1;
        d   = 10;
        e   = .1;
    case 2 %stable values
        a   = 10;
        b   = 10^(-5);
        c   = .1;
        d   = 10;
        e   = .1;
    otherwise %fluctuating values
        a   =10;
        b   =.001;
        c   =.4;
        d   =10;
        e   =.4;
end
    
Derivs = [(a-b*s(1)-c*s(2))*s(1) (-d+e*s(1))*s(2)];

return