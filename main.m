% Name: main
% Purpose: Run this file to see results of running cable simulation. Modify any experiment-specific parameters here. (For cell modifications, use init_LR1)
% Any modifications made to to fun_LR1 or init_LR1 should first be tested with the single_cell_test function.
clear all
close all
%% Simulation parameters
CABLE_DEBUG = 0; % Change to 1 if debugging single cell behavior without cable

dx = 0.025; % Space step size(mm), i.e. length of one cell
dt = 0.2; % Time step size(ms), consider decreasing to 0.1 if APs look too rough 

stim_size = 200; % Stimulus magnitude (uA/cm^2)
stim_time = [0 0.5]; % Time duration of stimulation(ms)
t_span = (0:dt:500); % Time duration of experiment(ms)
cell_num = 15; % Number of cells in cable
%D = 0.00154; % Diffusion coefficient(cm^2/s) (using g instead)
g_junc = (1.2/dx^2) / 1000; % Gap junction conductance(mS/cm^2), between 0.6 ~ 2.5

options = []; % Specify options to pass into ode15s if needed

%% Running cable

[y0, data] = init_LR1(); % Load in initial values for cells
cable_state_snapshot = zeros(cell_num, length(y0)); % Snapshot of cable after each iteration
cable_V = zeros(length(t_span), cell_num); % Store membrane voltages of each cell at every point in time

% Begin time loop
for i = 1:(length(t_span)-1)
    
    if i == 1 % Set initial cable conditions
        for n = 1:cell_num
            cable_state_snapshot(n,:) = y0;
        end
        
        cable_V(i, :) = y0(1);
        continue
    end
        
    dt_span = [ t_span(i) t_span(i+1) ];
    for n = 1:cell_num % Check if loop is at cell 1
        cell_1_flag = 0;
        if n == 1
            cell_1_flag = 1;
        end
        
        y_in = cable_state_snapshot(n, :);
        [t, y_out] = ode15s(@fun_LR1, dt_span, y_in, options, data, stim_size, stim_time, cell_1_flag); 
        
        cable_state_snapshot(n, :) = y_out(end, :); % Update cable snapshot of cell n for next timestep
        cable_V(i, n) = y_out(end, 1); % Store voltage values
    end
    
    dV_cells = zeros(1, cell_num);
    if CABLE_DEBUG == 0 % Calculate cable propogation
        for n = 1:cell_num
            if n == 1
                diff = cable_V(i, n+1) - cable_V(i, n);
            elseif n == cell_num
                diff = -cable_V(i, n) + cable_V(i, n-1);
            else
                diff = cable_V(i, n+1) - 2 * cable_V(i, n) + cable_V(i, n-1);
            end

            dV_cells(n) = diff * g_junc / data.C * dt;
        end
    end
     
    % Update cable with axial currents
    cable_state_snapshot(:, 1) = cable_state_snapshot(:, 1) + dV_cells.';
    cable_V(i, :) = cable_state_snapshot(:, 1);
end

cable_V(end, :) = cable_V(end-1, :);

plot_voltage()
