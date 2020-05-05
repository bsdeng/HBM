function [Mvec] =f231nonvar(MMat,n)

%% determine the length of each column which will be used in the relaxation
val=0;  
for k=1:1:n
    val=val+k;
    col(n+1-k,1)=val;
end
%% numbering each column
% monomials of degree == 0
for k=1:1:n
    mat(k,1)=k; mat(1,k)=k;
end
% monomials of degree == 1. This data will be used in the following loop
for k=1:1:n
    ma0(1,k)=1+k;
end
%% Construct a matrix where the entries are the columns.
% this also degree == n, the rest are degree == n+1
dia=1; diag=n;
for k0=2:1:n
    dia=diag+dia;
    mat(k0,k0)=dia; nondia=dia;
    for k=k0+1:1:n;
        nondia=nondia+1;
        mat(k0,k)=nondia; mat(k,k0)=nondia;
    end
    diag=diag-1;
end
for k1=1:1:n
    for k2=1:1:n
        mat(k1,k2)=mat(k1,k2)+1+n;
    end
end
maz=[ma0;mat];
%%
mc0=[]; %mc=[];
for j=1:1:n+1
for k=1:1:n
    mc1=MMat(length(MMat)-col(k,1):length(MMat)-1,maz(j,k));
    mc0=[mc0;mc1];
end
end

Mvec=mc0;
%%
