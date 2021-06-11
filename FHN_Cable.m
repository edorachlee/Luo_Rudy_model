clear all
close all

[y0, data] = init_LR1();
stim_size = 150;
stim_time = [0 0.5];
dt = 0.2;
t_span = (0:dt:500);
cell_num = 3;

% FHN Cable

Diffusion = 0.00154;        % Diffusion in the x direction (original = 0.00154)
nCell = cell_num;                % Number of cells in the cable. nCell=100
dx = 0.025; %0.01;          % Can go from 0.01 to 0.02 cm

v0=0; 
w0=0;
%y0=[v0;w0]; % Initials consitions

%JP = ones(2,2);

%% Cable integration
tic;
%dt = 0.2;
tspan = t_span'; %10e3

Vmem = zeros(nCell,1);
tempY = zeros(nCell,length(y0));
tempY0 = zeros(nCell,length(y0)); 

for n=1:nCell
    Cable(n).t = zeros(length(tspan),1);
    Cable(n).y = zeros(length(tspan),length(y0));
  
    tempY0(n,:) = y0;
    
    Vmem(n) = tempY0(n,1);
    Cable(n).t(1) = 0;
    Cable(n).y(1,:) = tempY0(n,:);
end

for j = 1:(length(tspan) - 1)
    
    T1 = tspan(j);
    T2 = tspan(j)+dt;
    parfor n = 1:nCell
              
        y0 = tempY0(n,:);
        p = n;
        options = odeset('RelTol',1e-5,'MaxStep',1,'Stats','off'); 
        %[t,y]=ode15s(@FHN_SingleCell,[T1 T2],y0, options,n);
        cell1_flag = 0;
        if n==1
            cell1_flag = 1;
        end
        [t, y] = ode15s(@fun_LR1, [T1 T2], y0, options, data, stim_size, stim_time, cell1_flag);
        
        Vmem(n) = y(size(y,1),1);
        tempY(n,:) = y(size(y,1),:); %new line
        
        %Displays where you are in the program
        if (n==1 && mod(T1, 100)==0)
            disp(T1);
        end
    
    end % end for 1: nCell (parfor loop)
    
    
    % Calculate axial current and update the voltage
    for n=1:nCell
        
        Cable(n).y(j+1,:)=tempY(n,:);
        
        if (n==1)
        I_axial = (Vmem(n+1) - Vmem(n))  *   Diffusion/(dx*dx);
        elseif (n>=2 && n<(nCell))
        I_axial = (Vmem(n+1) - 2*Vmem(n) + Vmem(n-1))  *  Diffusion/(dx*dx);
        elseif (n==(nCell))
        I_axial = (-Vmem(n) + Vmem(n-1)) *  Diffusion/(dx*dx);
        end
        
        Cable(n).y(j+1,1) = Vmem(n) + (I_axial)*dt;
        tempY0(n,:) = Cable(n).y(j+1,:); 
        Cable(n).t(j+1) = tspan(j+1);
        
    
    end % end for 2nd nCell loop, for axial current.
     
end % End for J loop of time. 
toc;

%% Figures
% figure(1)
% subplot(1,1,1); hold on, plot (Cable(1).t, Cable(1).y(:,1), '-k');
% subplot(1,1,1); hold on, plot (Cable(3).t, Cable(3).y(:,1), '--r');
% subplot(1,1,1); hold on, plot (Cable(nCell).t, Cable(nCell).y(:,1), '--b');
% 
% save('Test', 'Cable'); 
figure(1)
hold on 
for i=1:nCell
    plot(Cable(i).t, Cable(i).y(:,1))
end
hold off

%% FHN Single Cell Function
function dy = FHN_SingleCell(t,y,n)
    dy = zeros(2,1);
    a = 0.1;
    b = 0.5;
    if n ==1
        d = 0.5; % Setting this to nonzero creates autoauscillatory behavior
    else
        d = 0;
    end
    %d = 0.1; % Setting this to nonzero creates autoauscillatory behavior
    e = 0.01;
    g = 1;
    c = 0.1;
    
    %Original
    dy(1) = (a-y(1))*(y(1)-1)*y(1) - y(2);
    dy(2) = e*(b*y(1) - g*y(2) - d);

    
end


% 100 cells, 300ms: 
% ODE15s, JPattern: 107, 88, 85
% ODE15s, no JP: 81, 77, 78, 77