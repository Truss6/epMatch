function [V,s]=epMatch(target,flyer,V0,plotting)
    s=0;
    DUP=0.05;
%     figure();

    up=0;
    % flyer model
%     flyer=HugEl(Hug(1100,945,1.6),0,0);
    flyerV=V0;
    % P2=@(up) 1100*(945+1.6*up).*up; % approx PDMS model
    % P2 = flyer.PRESSURE;
    if plotting
        upv=0:2*flyerV/3;
        % plot(upv,P2(1000-upv),'c--');hold on;
        plot(upv,flyer.HUG.PRESSURE(flyerV-upv)/1e9,'c--');hold on;
        % plot(upv,RHO*(C0+S1*upv).*upv,'b--');
        plot(upv,target.HUG.PRESSURE(upv)/1e9,'b--');
        plot(upv,0*upv,'k--');
        u1=fsolve(@(u) flyer.HUG.PRESSURE(flyerV-u)-target.HUG.PRESSURE(u),flyerV/2);
        u2=2*u1;
        plot(upv,target.HUG.PRESSURE(u2-upv)/1e9,'b--')
    end

    %% shock
    % p=0;
    s=0;
    up=0;
    while (s+target.HUG.PRESSURE(up))<flyer.HUG.PRESSURE(flyerV-up)
        p=target.HUG.PRESSURE(up);
        s=target.getS(0,up);
        if plotting
            plot(up,(s+p)/1e9,'k.');hold on;
            plot(up,s/1e9,'g.');
            plot(up,p/1e9,'b.');
        end
        up=up+DUP;
    end
    if plotting
        ylim(1.5*[-target.SIGHEL,s+p]/1e9)
    end
    UP1=up;
    target.sDev=s;
    up=0;
    %% release
    while (s+p)>0
        up=up+DUP;
    %    Us=target.HUG.C0+target.HUG.S1*(UP1-up);
    %     p=RHO*Us*(UP1-up);
        p=target.HUG.PRESSURE(UP1-up);
    %     s=s-RHO*(CL)*DUP;
        s=target.getS(up,0);
    %     if(abs(s)>SIGHEL)
    %         s=SIGHEL*sign(s);
    %     end   
        if plotting
            plot(UP1+up,(s+p)/1e9,'k.');
            plot(UP1+up,s/1e9,'g.');
            plot(UP1+up,p/1e9,'b.');
        end
    %     pause(0);
    end
    V=UP1+up;
end