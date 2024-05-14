%%  epMatch expamle
clc;close all;clear;
%%
params=[2074;1.76]; %initial parameters
global c; c=1;%decimal 0-1, determines figure 1 plotting color, init c=1

err0=eval(params,true); % evaluate initial error
fprintf("RMSError: %0.1f\n",sqrt(err0/6)); % print initial error & plot impedance match
fprintf("Initial Parameters: C0 = %0.0f, s1 = %0.2f\n",params(1),params(2)); % print initial params

%%
params=fminsearch(@(p) eval(p,false),params); % optimization routine
%%
fprintf("RMSError: %0.1f\n",sqrt(eval(params,true)/6)); % print final error, plor impedance match
fprintf("Optimal Parameters: C0 = %0.0f, s1 = %0.2f\n",params(1),params(2)) % print final parameters
%%  Format Plots
figure(1);
format
subplot(121);format
xlabel("Hugoniot Intercept (C_0) [m/s]")
ylabel("Hugoniot Slope (s)")
title("Exploration")

subplot(222);format
title("Optimization: C_0")
xlabel("Hugoniot Intercept (C_0) [m/s]")
ylabel("Function Error (RMSE) [m/s]")

subplot(224);format
title("Optimization: S")
xlabel("Hugoniot Slope (s)")
ylabel("Function Error (RMSE) [m/s]")
%%
function err = eval(params,plotting)
    global c;   % declare variable c in function
    C=[(1-c)^2,0,16*c^2*(1-c)^2];
    figure(1);
    subplot(121);
    plot(params(1),params(2),'o','color',C);hold on; % plot current param
    if any(sign(params)==-1)
        % if any param is less than zero, return arbitrarily large error
        err=inf;
    else
        err=0;  % init error
        flyer=HugEl(Hug(1190,params(1),params(2)),0,0); % init flyer material
%         materials=[Al2024(),Cu(),SS304(),Al2024(),Cu(),SS304()]; % target materials
%         names=["Al",'Cu','SS','Al','Cu','SS']; % material names for plotting
%         vels=[365,365,365,503,503,503]; % flyer velocities
%         up2s=[125.9,59.8,53.8,185.4,90.7,78.7]; % experimental measurements

        materials=[Cu(),Cu(),Cu(),Cu(),Cu(),Al6061(),Al6061(),Al6061(),Al6061(),Al6061(),Ta(),Ta(),Ta(),Ta(),Ta()];
        names=["Cu","Cu","Cu","Cu","Cu","Al","Al","Al","Al","Al","Ta","Ta","Ta","Ta","Ta"];
        vels=[100,300,500,800,1200,100,300,500,800,1200,100,300,500,800,1200];
        up2s=[14.66,52.40,95.81,169.45,282.99,30.80,101.53,187.15,333.68,548.47,9.12,30.14,56.39,105.28,183.01];
        if plotting
            figure();clf;   % init fig
        end
        for i =1:length(up2s) % for each experiment
            if plotting
                subplot(3,5,i)
            end
            V=epMatch(materials(i),flyer,vels(i),plotting); % run epMatch, calculate up2
            err=err+(V-up2s(i))^2; % error = sum squared error
            if plotting
                plot(up2s(i),0,'ro'); % plot measured up2
                plot(V,0,'ko'); % plot theoretical up2
                
                % plot formating
                xlim(1.5*[0,max(up2s(i),V)])
                title(sprintf("%s %d",names(i),vels(i)),'fontsize',24);
                format;
                xlabel("Particle Velocity (u_p) [m/s]");
                ylabel("Stress (\sigma) [GPa]");
            end
        end
    end
    
    fprintf("R-squared: %0.5f\n",1-(err/(12249.215)))
    
    figure(1);
    % plot convergence
    subplot(222);
    semilogy(params(1),sqrt(err),'o','color',C);hold on;
    subplot(224);
    semilogy(params(2),sqrt(err),'o','color',C);hold on;
    c=c*0.985; %modify c
    pause(0);

end
function format
set(gca,'fontname','Cambria');
set(gca,'fontsize',18);
set(gcf,'color',[1 1 1]);
end