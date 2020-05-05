function [Mfnl]=f23nonl(nAFT,n,MMat,nh,d,nT,par)

ni=nfact(n,d-1)+1; 
nf=nfact(n,d);

[Mindex]=f232Index(n,d);
[Ga,Gp] =f233sparse(nT,nh);     % Gamma and iGamma 'matrices'
[Nb]    =f234Nbin(ni,nf,d,n,Mindex); %sdisplay(Nb) % Newton Binomial 'vector'











%% Construct a vector with redudant constraints
Mfnl=[];
for k=1:1:1+nAFT
    %% Construct a monomials vector
    %  Substitute all "nonlinear monomials" by "linear monomials"
    index=0; gg=sdpvar(nf-ni+1,1);
    for j =ni:1:nf
        index=index+1;
        gg(index,1)=MMat(j,k);
    end
    % Construct Nonlinear Vector
    for fn=1:1:nT%length(Ga)
        lm=0;
        for ct=ni:1:nf
            coe=1; lm=lm+1;
            for l =1:1:n%length(Ga)
                coe=coe*Ga(fn,l)^(Mindex(ct,l)-1);
            end
            ff(lm,lm)=coe;
        end
        fnl1(fn,1)=Nb'*ff*gg; 
    end
    %% From time domain back to frequency domain
    FFnl=Gp*(fnl1);
    Mfnl=[Mfnl;FFnl];
end