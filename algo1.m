function [dnh1]=algo1(par,nAFT,n,nh,d,FF,nT,po)

sdpvar t E E2 E3 E4; %N=1; E = sdpvar(N,1); 
% --- Generating Constraints ------------------------------------ %
tic
[aft,MMat,Moment]=f2AFT(par,nAFT,n,nh,d,FF,nT,E,po); % Lasserre+Sparsity
at=toc

tic
[x0d,x1d,MMat1] =f3DVA(t,n,MMat,nh);
[dm]            =f5SOSEucl(x0d,x1d,t,nh,MMat,MMat1,n,po,E,d); % --------------------------------------

con=[Moment; [1 E E2;E E2 E3;E2 E3 E4] >= 0;% 0.666 <= MMat(2,1) <= 0.85;
     dm >= 0; %E >= 0;
     aft ==zeros((2*nh+1)*(nAFT+1),1)]; 
obj=[(E2)]; 
%%
options = sdpsettings('solver','sedumi','verbose',1,'debug',1); 
sol=optimize(con,obj,options); 
et=toc

dobj=value(obj); dMat=value(MMat);
dnh1=dMat(2:n+1,1)
