classdef HugEl
    properties
        HUG;
        CL;
        SIGHEL;
        RHO;
        sDev=0;
        eps=0
    end
    methods
        function obj = HugEl(HUG,CL,SIGHEL)
            obj.HUG=HUG;
            obj.CL=CL;
            obj.RHO=HUG.RHO;
            obj.SIGHEL=SIGHEL;
        end
        function s = getS(obj,u0,u1)
%             clc;
%             dup=(u1-u0);
            s=obj.sDev+obj.RHO*obj.CL*(u1-u0);
            if abs(s)>obj.SIGHEL
                s0=s;
                s=obj.SIGHEL*sign(s);
%                 obj.eps=obj.eps+(s0-s)/(obj.RHO*obj.CL^2);
            end
        end
        function sig = getSig(obj,u0,u1,sgn)
%             clc;
%             dup=(u1-u0);
            s=obj.sDev+obj.RHO*obj.CL*(u1-u0);
            if abs(s)>obj.SIGHEL
                s0=s;
                s=obj.SIGHEL*sign(s);
%                 obj.eps=obj.eps+(s0-s)/(obj.RHO*obj.CL^2);
            end
            P=obj.HUG.PRESSURE(sgn*(u1-u0));
            sig=s+P;
            % return sig
        end        
    end
end