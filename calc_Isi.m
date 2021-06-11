function [Isi, ad, bd, af, bf] = calc_Isi(V, d, f, Cai, data)

    Esi = 7.7 - 13.0287 * log( Cai / data.Cao );
    Isi = 0.09 * d * f * ( V - Esi );
    
    ad = 0.095 * exp( -0.01 * ( V - 5 ) ) / ( 1 + exp( -0.072 * ( V - 5 ) ) );
    bd = 0.07 * exp( -0.017 * ( V + 44 ) ) / ( 1 + exp( 0.05 * (V + 44 ) ) );
    af = 0.012 * exp( -0.008 * ( V + 28 ) ) / ( 1 + exp( 0.15 * ( V + 28 ) ) );
    bf = 0.0065 * exp( -0.02 * ( V + 30 ) ) / ( 1 + exp( -0.2 * ( V + 30 ) ) );
    
end
    