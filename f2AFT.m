function [aft,MMat,Moment]=f2AFT(par,nAFT,n,nh,d,FF,nT,E,po)

nc=n; drelax=2*d;
epol=nfact(n,drelax);
M=sdpvar(epol,1); 

%% ------------------------------------------------------------------------
%[MMat]=g21mon0func(d,drelax,n,nc,M,FF,epol,par,E); %sdisplay(MMat)
[MMat,Moment,F]=g21mon1func(d,drelax,n,nc,M,FF,epol,par,E);
%% ------------------------------------------------------------------------
[Mlin]=f22line(nAFT,n,MMat,par); 
[Mfnl]=f23nonl(nAFT,n,MMat,nh,d,nT,par);         
[Fext]=f24exte(nAFT,n,F,par);
%
beta=par(2);
aft=(Mlin)+(beta*Mfnl)+(Fext);

%% ------------------------------------------------------------------------
