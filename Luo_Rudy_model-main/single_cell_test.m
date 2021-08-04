% Name: single_cell_test
% Purpose: Before running main, use this file to test/debug any modifications made to the single cell model(fun_LR1 and/or init_LR1)
clear all
close all

[y0, data] = init_LR1();
stim_size = 80;
stim_time = [0 0.5];
t_span = [0 600];
options = [];

[t,y] = ode15s(@fun_LR1, t_span, y0, options, data, stim_size, stim_time, 1);
figure(1)
plot(t, y(:,1), 'linewidth', 3)
title('AP - Test')
xlabel('Time (ms)')
ylabel('Membrane Voltage (mV)')