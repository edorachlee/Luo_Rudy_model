% Name: calc_IK
% Purpose: Calculate time-dependent potassium current[Outward]
function [IK, aX, bX] = calc_IK(V, X, data)

    GK = 0.282 * sqrt( data.Ko / 5.4 );
    if (V <= -100)
        Xi = 2.837 * ( exp( 0.04 * ( V + 77 ) ) - 1 ) / ( ( V + 77 ) * ( exp( 0.04 * ( V + 35 ) ) ) );
    else
        Xi = 1;
    end
    EK = data.RTF * log( ( data.Ko + data.PR * data.Nao ) / ( data.Ki + data.PR * data.Nai ) ); % mV

    IK = GK * X * Xi * ( V - EK ); % 
    aX = 0.0005 * exp( 0.083 * ( V + 50 ) ) / ( 1 + exp( 0.057 * ( V + 50 ) ) );
    bX = 0.0013 * exp( -0.06 * ( V + 20 ) ) / ( 1 + exp( -0.04 * ( V + 20 ) ) );
end