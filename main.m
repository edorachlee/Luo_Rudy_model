clear all
close all

WRAPPER_DEBUG = 0;

[y0, data] = init_LR1();

dx = 0.025;
dt = 0.2;

stim_size = 200;
stim_time = [0 0.5];
t_span = (0:dt:500);
cell_num = 15;

D = 0.00154;
g = (1.2/dx^2) / 1000; %mS/cm^2, 0.6 ~ 2.5

options = [];

cable_state_snapshot = zeros(cell_num, length(y0));
cable_V = zeros(length(t_span), cell_num);

for i = 1:(length(t_span)-1)
    
    if i == 1 % Set intial cable conditions
        for n = 1:cell_num
            cable_state_snapshot(n,:) = y0;
        end
        
        cable_V(i, :) = y0(1);
        continue
    end
        
    dt_span = [ t_span(i) t_span(i+1) ];
    for n = 1:cell_num
        cell1_flag = 0;
        if n == 1
            cell1_flag = 1;
        end
        
        y_in = cable_state_snapshot(n, :);
        [t, y_out] = ode15s(@fun_LR1, dt_span, y_in, options, data, stim_size, stim_time, cell1_flag); 
        
        cable_state_snapshot(n, :) = y_out(end, :); %update cable snapshot of cell n for next timestep
        cable_V(i, n) = y_out(end, 1); %store voltage values
    end
    
    dV_cells = zeros(1, cell_num);
    if WRAPPER_DEBUG == 0
        for n = 1:cell_num
            if n == 1
                diff = cable_V(i, n+1) - cable_V(i, n);
            elseif n == cell_num
                diff = -cable_V(i, n) + cable_V(i, n-1);
            else
                diff = cable_V(i, n+1) - 2 * cable_V(i, n) + cable_V(i, n-1);
            end

            %dV_cells(n) = diff * D / dx^2 * dt;
            dV_cells(n) = diff * g / data.C * dt;
        end
    end
    %disp(dV_cells)
     
    %update cable with axial currents
    cable_state_snapshot(:, 1) = cable_state_snapshot(:, 1) + dV_cells.';
    cable_V(i, :) = cable_state_snapshot(:, 1);
end

cable_V(end, :) = cable_V(end-1, :);

plot_voltage()
