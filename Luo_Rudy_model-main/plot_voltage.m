% Name: plot_voltage
% Purpose: Use this file to plot voltage values of cable after simulation ends.
% If the cable has many cells, change cell_num in figure(2) to plot the first X number of cells.

close all
figure(1)
for n=1:cell_num
    subplot(2,ceil(cell_num/2),n)
    plot(t_span, cable_V(:, n), 'linewidth', 3)
    title('Cell ' + string(n) + ' Voltage')
    xlabel('Time (ms)')
    ylabel('Vm (mV)')
    ylim([-90 50])
    %xlim([0 200])
end

figure(2)
hold on
for n=1:cell_num
    plot(t_span, cable_V(:, n), 'linewidth', 3)
    title('AP Propagation Along Cable')
    xlabel('Time (ms)')
    ylabel('Vm (mV)')
    %ylim([-90 60])
    xlim([0 20])
end
    