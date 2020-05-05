function [Nb]=f234Nbin(ni,nf,d,n,Mind)

Nb=[];    num=factorial(d);
for j1=ni:1:nf
    den=1;
    for j2=1:1:n
        den=den*factorial(Mind(j1,j2)-1);
    end
    mj=num/den;
    Nb=[Nb;mj];
end     