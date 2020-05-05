function [MMat,k1e,k2e,j]=n2symm(MMat,jini,n,counter,M,j,krini,krend,kcini,kcend)

n=n+1-counter;
j=jini+nfact(n,1)-1; %n+1-counter; %j=jini+1+(kcend-kcini) %j=jini+n;
k1e=n-1; %n-counter
k2e=n-1;
ns=0;

if k1e > 0
    
Sym=sdpvar(k1e);
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
k1i=krini; k1e=krend;
k2i=kcini; k2e=kcend;

if k1e-k1i+1 >= 0
MMat(k1i:k1e,k2i:k2e)=Sym;
end

end