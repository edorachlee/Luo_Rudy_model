function Ib = calc_Ib(V)

    Gb = 0.03921;
    Eb = -59.87; %mV
    Ib = Gb * ( V - Eb );
end