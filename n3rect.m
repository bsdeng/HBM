function [MMat]=n3rect(MMat,krini,n,counter,krend,kcini,counter4,jini,M,k1,k2,j)

jini=j;                 
krini=krini+n+1-counter;
krend=krend;
kcini=kcini+1;          
kcend=kcini+n-1-counter;
for counter2=counter:1:n-1
    [MMat,j]=n1rowcol(MMat,krini,krend,kcini,kcend,M,jini);
    % ----------------------
    k1e=n-counter-1; k2e=n-counter-1; ns=0;
    if k1e >= 0
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
    end
    k1i=krini+1; k1e=krini+n-counter-1;
    k2i=kcini+1; k2e=kcini+n-counter-1;
    if k1e-k1i >= 0
        MMat(k1i:k1e,k2i:k2e)=Sym; MMat(k2i:k2e,k1i:k1e)=Sym;
    end
    % --- update
    n=n-1; jini =j;
    krini=k1e+1; %sdisplay(krini)
    kcini=k2i; %sdisplay(kcini)
end