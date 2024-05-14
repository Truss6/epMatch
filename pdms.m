%%  epMatch expamle
clc;close all;clear;
% al6061=Al6061()
% al2024=Al2024()
% cu=Cu
% pc=PC
% ss304=SS304()
params=[958;1.57];
err0=eval(params,true);
fprintf("RMS-Error: %0.0f\n",sqrt(err0/3));
fprintf("Initial Parameters: C0 = %0.0f, s1 = %0.2f\n",params(1),params(2));
%%
params=fminsearch(@(p) eval(p,false),params);
% params=fmincon(@(p) eval(p),[1680;2.26],-1*eye(2),[0;0])
fprintf("RMS-Error: %0.2g\n",sqrt(eval(params,true))/3);
fprintf("Optimal Parameters: C0 = %0.0f, s1 = %0.2f\n",params(1),params(2))
%%
figure(1)
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
%   377.5
function err = eval(params,plotting)
    figure(1);
    subplot(121);
    plot(params(1),params(2),'ko');hold on;
    if any(sign(params)==-1)
        err=inf;
        
    else
        err=0;
    
        flyer=HugEl(Hug(1088,params(1),params(2)),0,0);
        materials=[Al6061(),PC(),Cu(),Al6061(),PC(),Cu(),Al6061(),PC(),Cu()];
        names=["Al","PC","Cu","Al","PC","Cu","Al","PC","Cu"];
        vels=[377,377,377,130,130,130,29,29,29];
        up2s=[80.19,270.1,35.48,20.45,88.9,8.65,5.31,16.8,1.56];%,185.4,90.7,78.7];
    %     err=0;
        if plotting
            figure();clf;
        end
        for i =1:length(up2s)
            if plotting
                subplot(3,3,i)
            end
            V=epMatch(materials(i),flyer,vels(i),plotting);
            err=err+(V-up2s(i))^2; % sum squared error
            if plotting
                plot(up2s(i),0,'ro');
                plot(V,0,'ko');
                xlim(1.5*[0,max(up2s(i),V)])
                title(sprintf("%s %d",names(i),vels(i)));
                format;                
            end
        end
        
    end
%     disp(err)
    %{
%     [V,s]=epMatch(Al2024(),flyer,365);
%     err=err+(V-125.9)^2;
%     [V,s]=epMatch(Cu(),flyer,365);
%     err=err+(V-59.8)^2;
%     [V,s]=epMatch(SS304(),flyer,365);
%     err=err+(V-53.8)^2;
%     [V,s]=epMatch(Al2024(),flyer,503);
%     err=err+(V-185.4)^2;
%     [V,s]=epMatch(Cu(),flyer,503);
%     err=err+(V-90.7)^2;
%     [V,s]=epMatch(SS304(),flyer,503);
%     err=err+(V-78.7)^2
    %}
    figure(1);
    subplot(222);
    semilogy(params(1),sqrt(err),'ko');hold on;
    subplot(224);
    semilogy(params(2),sqrt(err),'ko');hold on;

    pause(0);

end
function format
set(gca,'fontname','Cambria');
set(gca,'fontsize',16);
set(gcf,'color',[1 1 1]);
end