function mat=PC
RHO=1190;C0=2007.16;S1=2.41;
E=3.2e9;NU=0.35;
Y=63e6;
M=E*(1-NU)/((1+NU)*(1-2*NU));
% CL=sqrt(M/RHO)-C0;
% CL=2330-C0;
    CL = C0*0.5*(1-2*NU)/(1+NU);
SIGHEL=2*Y/3;% f(Y,nu);
mat=HugEl(Hug(RHO,C0,S1),CL,SIGHEL);
end