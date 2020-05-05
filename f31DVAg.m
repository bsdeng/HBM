function [Ia,Ib]=f31DVAg(n)

Ia=eye(n);

% nabla
Ib=zeros(n,n); j=1;
for k=3:2:n
    Ib(k-1,k)=-1*j;
    Ib(k,k-1)=1*j;
    j=j+1;
end