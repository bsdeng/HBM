function [Mlin]=ff2line(nAFT,n,MMat,par,po)

% Loading parameter values
alpha=par(1); beta=par(2); delta=par(3); w=par(4); G=par(5);
px0=po(1,1); px1=po(1,2);

% Computing the auxiliar matrices nabla and nabla squared
[nabla]=f221nabla(n);
%% Construct a vector with redudant constraints
MMlin=[];
for j=1:1:1
    A=[];
    for k=1:1:n
        A=[A;MMat(k+1,j)]; 
    end
    Mlin=( (-2*px1*w*nabla) + (-2*px0*eye(n)) )*A;
    MMlin=[MMlin;Mlin];
end

%% Output
Mlin=MMlin;