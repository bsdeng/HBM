function [Mlin]=f22line(nAFT,n,MMat,par)

% Loading parameter values
alpha=par(1); delta=par(3); w=par(4);
% Computing the auxiliar matrices nabla and nabla squared
[nabla,nablb]=f221nabla(n);

%% Construct a vector with redudant constraints
MMlin=[];
for j=1:1:1+nAFT
    A=[];
    for k=1:1:n
        A=[A;MMat(k+1,j)]; 
    end
    Mlin=((w^2*nablb)+(delta*w*nabla)+(alpha*eye(n)))*A;
    MMlin=[MMlin;Mlin];
end

%% Output
Mlin=MMlin;