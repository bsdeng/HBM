function [Fext]=ff4exte(nAFT,n,MMat,par,E,po)

alpha=par(1); beta=par(2); delta=par(3); w=par(4); G=par(5);
px0=po(1,1); px1=po(1,2);
%% Construct a vector with redudant constraints
MFext=[];
for j=1:1:1
    Fm=sdpvar(n,1);
    for k=1:1:n
        if     k==1
            Fm(k,1)=px0^2+px1^2-E;
        else
            Fm(k,1)=0;
        end
    end
    Fext=eye(n)*Fm;
    MFext=[MFext;Fext];
end

%% Output
Fext=MFext;