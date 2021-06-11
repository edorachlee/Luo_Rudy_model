function dy = fun_LR1(t, y, data)
V = y(1); m = y(2); h = y(3); j = y(4); d = y(5); f = y(6); X = y(7); Ca_i = y(8);

%% Currents

[INa, am, bm, ah, bh, aj, bj] = calc_INa(V, m, h, j, data);
[Isi, ad, bd, af, bf] = calc_Isi(V, d, f, Cai, data);
[IK, aX, bX] = calc_IK(V, X, data);
IK1 = calc_IK1(V, data);
IKp = calc_IKp(V, data);
Ib = calc_Ib(V);

%% ODEs

%farad = s / ohm
dV = -(1/data.C)*(I_ion-I_stim); % mV/ms * cm^2
%[1/(uF/cm^2)] * uA = cm^2/uF *uA = cm^2/F * A = cm^2 * A/F 
%= cm^2 * A*ohm/s = cm^2 * V/s
%= mV/ms * cm^2

dm = diff_gate(m, am, bm);
dh = diff_gate(h, ah, bh);
dj = diff_gate(n, aj, bj);
dd = diff_gate(d, ad, bd);
df = diff_gate(f, af, bf);
dX = diff_gate(X, aX, bX);
end




