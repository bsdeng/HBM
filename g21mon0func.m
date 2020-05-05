function [MMat]=g21mon0func(d,drelax,n,nc,M,FF,epol,par,E)

G=0;
kend=nfact(n,d); 
MMat=sdpvar(kend+2,kend+2);
%
for counter=1:1:n
    %counter
    [MMat]=g211mon1vec(counter,M,MMat,d,drelax,n); % - 1  - % --- ok
    [MMat]=g212mon2mat(counter,M,MMat,d,drelax,n); % - 2  - % --- ok
    [MMat]=g213mon3(MMat,nc,counter,M,n,d,drelax); % - 3  - % --- ok
    [MMat]=g214mon4(MMat,counter,n,drelax,M);      % - 4  - % --- ok
    [MMat]=g215mon4rec(MMat,counter,drelax,n,d,M); % - 4s - % --- ok
    [MMat]=g216mon5(MMat,counter,n,drelax,d,M);    % - 5  - % --- ok
end
MMat(kend,kend)=M(epol);
%%
l=length(MMat); MMat(l,1)=FF; MMat(1,l)=FF;

FM=sdpvar(l,1); 
for ind=1:1:l
    if ind == 1
        FM(ind,1)=(FF);
    elseif ind == l-1
        FM(ind,1)=(FF)^2;
    elseif ind == l
        FM(ind,1)=(FF)*(G);
    end
end
MMat(l-1,:)=FM; MMat(:,l-1)=FM';

xM=sdpvar(l,1);
for ind=1:1:l
    if ind == 1
        xM(ind,1)=(G);
    elseif ind == l-1
        xM(ind,1)=(FF)*(G);
    elseif ind == l
        xM(ind,1)=(G)^2;
    end
end
MMat(l,:)=xM; MMat(:,l)=xM';