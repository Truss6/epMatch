function mat = Ta
    RHO=16650;C0=3410;S1=1.2;
    E=186e9;NU=0.35;
    Y=450e6;
%     M=E*(1-NU)/((1+NU)*(1-2*NU));
%     K=E/(3*(1-2*NU));
%     C0=sqrt(K/RHO);
%     CL=sqrt(M/RHO)-C0;
%     G=E/(2*(1+NU));
%     CL=sqrt(G/RHO);
    CL = C0*0.5*(1-2*NU)/(1+NU);

%     G=E/(2*(1+NU));
%     CL=sqrt((4*G)/(3*RHO));
    SIGHEL=2*Y/3;% f(Y,nu);
    mat=HugEl(Hug(RHO,C0,S1),CL,SIGHEL);
end