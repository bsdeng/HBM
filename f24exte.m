function [Fext]=f24exte(nAFT,n,F,par)

%% Construct a vector with redudant constraints
MFext=[];
for j=1:1:1+nAFT
    Fm=sdpvar(n,1);
    for k=1:1:n
        if k==2
            Fm(k,1)=-F(j);
        else
            Fm(k,1)=0;
        end
    end
    Fext=eye(n)*Fm;
    MFext=[MFext;Fext];
end

%% Output
Fext=MFext;