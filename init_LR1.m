function [y0, data] = init_LR1()
%% Initialize Constants
F = 96.5;                   % Faraday constant, coulombs/mmol
R = 8.314;                  % gas constant, J/(mol*K)
T = 273+37; % absolute temperature, K
data.RTF=(R*T/F); %mV
data.C = 1; %uF/cm^2
data.GNa = 23; %mS/cm^2 
data.Nai = 18; %mM **Sample code sets to 10!
data.Nao = 140; %exp(data_new.ENa / data_new.RTF)*data_new.Nai; %mM
%data.ENa = 54.4; %mV, calculated from Nai = 18, Nao = 140;
data.PR = 0.01833; %Na/K permeability ratio
data.Ki = 145; %mM %1/( exp(-77 / data_new.RTF) / (5.4+data_new.PR*data_new.Nao) ) - (data_new.PR*data_new.Nai); %calculated with Ko = 5.4 mM, EK = -77 mV
data.Ko = 5.4; %mM - can be changed!
data.Cao = 1.8; %mM
%data.EK = -77; %mV - can be changed!


%% Set inital values
V_init= -84.5286 ;  
m_init = 0.0017; % sodium current activation gate
h_init = 0.9832;  % sodium current fast inactivation
j_init = 0.995484;   %  slow inactivation
d_init = 0.000003; % Calcium activation gate
f_init = 1.0000 ;  % Calcium  inactivation gate
X_init = 0.0057 ; % activation gate
Cai_init = 0.0002; % Calcium

y0=[ V_init m_init h_init j_init d_init f_init X_init Cai_init];
end