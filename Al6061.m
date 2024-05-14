function mat=Al6061
RHO=2700;C0=5350;S1=1.34;
E=72e9;NU=0.33;
Y=270e6;
% M=E*(1-NU)/((1+NU)*(1-2*NU));
% CL=sqrt(M/RHO)-C0;
%     G=E/(2*(1+NU));
%     CL=sqrt((4*G)/(3*RHO));
    CL = C0*0.5*(1-2*NU)/(1+NU);
SIGHEL=2*Y/3;% f(Y,nu);
mat=HugEl(Hug(RHO,C0,S1),CL,SIGHEL);
end