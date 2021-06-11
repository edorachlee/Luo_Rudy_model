clear all
close all

[y0, data] = init_LR1();
stim_size = 80;
stim_time = [0 0.5];

[t,y] = ode15s(@fun_LR1, [0 600], y0, [], data, stim_size, stim_time, 1);
figure(1)
plot(t, y(:,1))

% for i = 1:5
%     y0(1) = y0(1)+10;
% 
%     [t,y] = ode15s(@fun_LR1, [0 600], y0, [], data, stim_size, stim_time, 1);
% 
%     figure(i)
%     plot(t, y(:, 1))
% end