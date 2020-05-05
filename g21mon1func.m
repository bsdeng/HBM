function [MMat,Moment,F]=g21mon1func(d,drelax,n,nc,M,FF,epol,par,E)

kend=nfact(n,d-1); MMat=sdpvar(2,2); GG=0;
%
for counter=1:1:1
    %counter
    [MMat]=g211mon1vec(counter,M,MMat,d,drelax,n); % - 1  - % --- ok
    [MMat]=g212mon2mat(counter,M,MMat,d,drelax,n); % - 2  - % --- ok
    [MMat]=g213mon3(MMat,nc,counter,M,n,d,drelax); % - 3  - % --- ok
    [MMat]=g214mon4(MMat,counter,n,drelax,M);      % - 4  - % --- ok
    [MMat]=g215mon4rec(MMat,counter,drelax,n,d,M); % - 4s - % --- ok
%    [MMat]=g216mon5(MMat,counter,n,drelax,d,M);    % - 5  - % --- ok
end
%sdisplay(MMat)
%%
Fvec=sdpvar(nfact(n,2)-1,1); F=[FF;Fvec]; %sdisplay(F)
Gvec=sdpvar(nfact(n,2)-1,1); G=[GG;Gvec];
MMM=[MMat(1:nfact(n,2),1:nfact(n,2)) F     G;
     F'                              FF^2  FF*GG;
     G'                              FF*GG GG^2]; %sdisplay(MMM)
Moment=[MMM >= 0];
for i=1:1:nfact(n,d)-nfact(n,d-1)
    moment=[MMat(1:n+1,1:n+1)        MMat(1:n+1,nfact(n,2)+i);
            MMat(nfact(n,2)+i,1:n+1) sdpvar(1)];%MMat(nfact(n,2)+i,nfact(n,2)+i)];
        %sdisplay(moment)
    Moment=[Moment;moment >=0];
end