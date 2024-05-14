classdef Hug
    properties
        C0;
        S1;
        RHO;
        PRESSURE;
        US;
    end
    methods
        function obj = Hug(RHO,C0,S1)
            obj.C0=C0;
            obj.RHO=RHO;
            obj.S1=S1;
            
            obj.PRESSURE=@(u) RHO*(C0+S1*u).*u;
            obj.US=@(u) C0+S1*u;
        end
    end
end