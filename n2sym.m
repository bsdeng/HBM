function [MMat,k1e,k2e,j]=n2sym(MMat,jini,n,counter,M,j,krini,krend,kcini,kcend)

j=jini+n+1-counter; %j=jini+1+(kcend-kcini) %j=jini+n;
k1e=n-counter;
k2e=n-counter;
ns=0; 

if k1e >= 0
Sym=sdpvar(k1e);
%end

for k1=1:1:k1e
    for k2=1+ns:1:k2e
        Sym(k1,k2)=M(j);
        if k1 ~= k2
            Sym(k2,k1)=M(j);
        end
        j=j+1;
    end
    ns=ns+1;
end

if kcend-kcini >= length(Sym)
    k1i=krini+1;
    k1e=krini+n-counter;
    k2i=kcini+1;
    k2e=kcini+n-counter;
elseif kcend == krend
    k1i=krini+1; k1e=krini+kcend-kcini;       %sdisplay(k1e)
    k2i=kcini+1; k2e=kcend;                   %sdisplay(k2i)
else
    k1i=krini+1; k1e=krini+n-counter;
    k2i=kcini+1; k2e=kcini+n-counter;
end

if k1e-k1i >= 0
MMat(k1i:k1e,k2i:k2e)=Sym; MMat(k2i:k2e,k1i:k1e)=Sym;
end

end