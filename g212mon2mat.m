function [MMat]=g212mon2mat(counter,M,MMat,d,drelax,n)

% computing the starting j
kstart=2; kini=0;
if counter == 1
    kini=kstart;
else
    for k=2:1:counter
        nk=n+2-k;
        dk=d-1;
        kini=kini+(factorial(nk+dk)/(factorial(nk)*factorial(dk)));
    end
    kini=kini+kstart;
end

% computing the starting kini
j=0;
if counter == 1
    j=1+n+2-counter;
else
    for k=2:1:counter
        nk=n+(2-k);
        dk=drelax-1;
        j=j+(factorial(nk+dk)/(factorial(nk)*factorial(dk)));
    end
    j=j+(1+n+2-counter);
end
%%
ns=0;
k1i=kini;
k2i=kini;

k1e=kini+n-counter;
k2e=kini+n-counter;
for k1=k1i:1:k1e
    for k2=k2i+ns:1:k2e
        MMat(k1,k2)=M(j);
        if k1 ~= k2
            MMat(k2,k1)=M(j);
        end
        j=j+1;
    end
    ns=ns+1;
end