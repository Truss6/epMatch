function mat=Al2024
    RHO=2790;C0=5330;S1=1.34;
    E=73.1e9;NU=0.33;
    Y=75.8e6;
%     M=E*(1-NU)/((1+NU)*(1-2*NU));
%     K=E/(3*(1-2*NU));
%     C0=sqrt(K/RHO);
%     CL=sqrt(M/RHO)-C0;
%     G=E/(2*(1+NU));
%     CL=sqrt(G/RHO);
    CL = C0*0.5*(1-2*NU)/(1+NU);
    SIGHEL=2*Y/3;% f(Y,nu);
    mat=HugEl(Hug(RHO,C0,S1),CL,SIGHEL);
end