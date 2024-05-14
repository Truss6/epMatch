function mat=SS304
    RHO=7900;C0=4570;S1=1.49;
    E=193e9;NU=0.29;
    Y=215e6;
%     M=E*(1-NU)/((1+NU)*(1-2*NU));
%     K=E/(3*(1-2*NU));
%     C0=sqrt(K/RHO);
%     CL=sqrt(M/RHO)-C0;
%     G=E/(2*(1+NU));
%     CL=sqrt(G/RHO);
    G=E/(2*(1+NU));
    CL=C0*0.5*(1-2*NU)/(1+NU);%sqrt((4*G)/(3*RHO));
    SIGHEL=2*Y/3;
    mat=HugEl(Hug(RHO,C0,S1),CL,SIGHEL);
end