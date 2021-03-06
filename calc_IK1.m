% Name: calc_IK1
% Purpose: Calculate time-independent potassium current[Outward]
function IK1 = calc_IK1(V, data)
    GK1 = 0.6047 * sqrt( data.Ko / 5.4 );
    EK1 = data.RTF * log( data.Ko / data.Ki );
    aK1 = 1.02 / ( 1 + exp( 0.2385 * ( V - EK1 - 59.215 ) ) );
    bK1 = ( 0.49124 * exp ( 0.08032 * ( V - EK1 + 5.476 ) ) + exp ( 0.06175 * ( V - EK1 - 594.31 ) ) )...
        / ( 1 + exp( -0.5143 * ( V - EK1 + 4.753 ) ) );
    
    K1_inf = aK1 / ( aK1 + bK1 );
    
    IK1 = GK1 * K1_inf * ( V - EK1 );
end