function [MMat]=g211mon1vec(counter,M,MMat,d,drelax,n)

% computing the starting j
j=1;
if counter == 1
    j=1;
else
    for k=2:1:counter
        nk=n+(2-k);
        dk=drelax-1;
        j=j+(factorial(nk+dk)/(factorial(nk)*factorial(dk)));
    end
end

% computing the starting kini
kini=1;
if counter == 1
    kini=1;
else
    for k=2:1:counter
        nk=n+(2-k);
        dk=d-1;
        kini=kini+(factorial(nk+dk)/(factorial(nk)*factorial(dk)));
    end
end

% computing the ending position kend
kend=factorial(n+d)/(factorial(n)*factorial(d));

% Placing the monomials in their respective order
for k=kini:1:kend
    if k == 1
        MMat(1,1) = 1;
    else
        MMat(k,kini)=M(j);
        if k ~= kini
        MMat(kini,k)=M(j);
        end
    end
    j=j+1;
end