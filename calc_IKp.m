function IKp = calc_IKp(V, data)

    GKp = 0.0183;
    Kp = 1 / ( 1 + exp( ( 7.488 - V ) / 5.98) );
    EKp = data.RTF * log( data.Ko / data.Ki ); % = EK1
    IKp = GKp * Kp * ( V - EKp );
end