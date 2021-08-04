% Name: calc_Ib
% Purpose: Calculate background leakage current[Outward]
function Ib = calc_Ib(V)
    Gb = 0.03921;
    Eb = -59.87;
    Ib = Gb * ( V - Eb );
end