function [INa, am, bm, ah, bh, aj, bj] = calc_INa(V, m, h, j, data)

    ENa = data.RTF * log(data.Nao/data.Nai); % mV (since data.RTF is in mV)
    INa = data.GNa * ( m^3 ) * h * j * ( V - ENa ); %uA/cm^2
    %mS/cm^2 * mV = 10e-3/(ohm*cm^2) * 10e-3 * V = 10e-6 * V/(ohm*cm^2) 
    %= 10e-6 * A/cm^2 = uA/cm^2

    am = 0.32*( V + 47.13 ) / (1 - exp( -0.1 * ( V + 47.13 ) ) );
    bm = 0.08 * exp( -V / 11 );
    if (V >= -40)
        ah = 0; 
        aj = 0;
        bh = 1 / ( 0.13 * ( 1 + exp( ( V + 10.66 ) / -11.1 ) ) );
        bj = 0.3 * exp( -2.535 * 10^-7 * V ) / ( 1 + exp( -0.1 * ( V + 32 ) ) );
    else
        ah = 0.135 * exp( ( 80 + V ) / -6.8 );
        bh = 3.56 * exp( 0.079 * V ) + 3.1 * 10^5 * exp( 0.35 * V );
        aj = ( -1.2714 * 10^5 * exp( 0.2444 * V ) - 3.474 * 10^-5 * exp( -0.04391 * V ) )...
            * ( V + 37.78 ) / ( 1 + exp( 0.311 * ( V + 79.23 ) ) );
        bj = 0.1212 * exp( -0.01052 * V ) / ( 1 + exp( -0.1378 * ( V + 40.14 ) ) );
    end
    
end
    


