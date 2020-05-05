function [nabla,nablb]=f221nabla(n)

% nabla
nabla=zeros(n,n); j=1;
for k=3:2:n
    nabla(k-1,k)=1*j;
    nabla(k,k-1)=-1*j;
    j=j+1;
end

% nabla squared
nablb=nabla^2;
