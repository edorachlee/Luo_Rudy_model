% Name: fun_LR1
% Purpose: This file contains the ordinary differential equations(ODEs) for the single cell model. 
% This file isn't usually changed. Use init_LR1 to modify any experiment parameters.
% Units: Current = uA/cm^2, Conductance = mS/cm^2, Voltage/Nernst Potential = mV, Time = ms 
% Parameters: 
% t: experiment time duration, 
% y: calculated values of variables after ODEs, 
% data: model parameters, 
% stim_size: stimulus current magnitude,
% stim_time: duration of stimulus, 
% cell_1_flag: flag showing whether the first cell is being simulated
function dy = fun_LR1(t, y, data, stim_size, stim_time, cell_1_flag)
V = y(1); m = y(2); h = y(3); j = y(4); d = y(5); f = y(6); X = y(7); Cai = y(8);

%% Calculate Currents
[INa, am, bm, ah, bh, aj, bj] = calc_INa(V, m, h, j, data);
[Isi, ad, bd, af, bf] = calc_Isi(V, d, f, Cai, data);
[IK, aX, bX] = calc_IK(V, X, data);
IK1 = calc_IK1(V, data);
IKp = calc_IKp(V, data);
Ib = calc_Ib(V);

%% Calculate ODEs
%farad = s / ohm
I_sum = INa + Isi + IK + IK1 + IKp + Ib;

if (cell_1_flag ==1)
    if (t <= stim_time(2) && t >= stim_time(1))
        I_stim = stim_size;
    else
        I_stim = 0;
    end
else
    I_stim = 0;
end

dV = -(1/data.C)*(I_sum-I_stim); % mV/ms
% Unit conversion: 
%[1/(uF/cm^2)] * uA/cm^2 = cm^2/uF *uA/cm^2 = uA/uF
%= A/F = A * ohm/s = V/s = mV/ms

dm = diff_gate(m, am, bm);
dh = diff_gate(h, ah, bh);
dj = diff_gate(j, aj, bj);
dd = diff_gate(d, ad, bd);
df = diff_gate(f, af, bf);
dX = diff_gate(X, aX, bX);
dCai = -10^-4 * Isi + 0.07 * ( 10^-4 - Cai );

dy = [dV; dm; dh; dj; dd; df; dX; dCai];
end




