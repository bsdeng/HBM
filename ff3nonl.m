function [Mfnl]=ff3nonl(nAFT,n,MMat,nh,d,nT,par)

alpha=par(1); delta=par(3); w=par(4); G=par(5);
d=2;
ni=factorial(n+d-1)/(factorial(n)*factorial(d-1))+1;
nf=factorial(n+d)/(factorial(n)*factorial(d));

[Mindex]=f232Index(n,d);
[Ga,Gp] =f233sparse(nT,nh);     % Gamma and iGamma 'matrices'
[Nb]    =f234Nbin(ni,nf,d,n,Mindex); %sdisplay(Nb) % Newton Binomial 'vector'
% [Mindez]=h232Index(n,d);
% [Nc]    =h235Nbin( 1,10,d,n,Mindez);
%% Construct a vector with redudant constraints
Mfnl=[];
for k=1:1:1
    %% Construct a monomials vector
    %  Substitute all "nonlinear monomials" by "linear monomials"
    index=0; %gg=sdpvar(nfact(n,d)-nfact(n-1,d),1);
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
    %% Construct a monomials vector
%     %Substitute all "nonlinear monomials" by "linear monomials"
%     index=0; gi=sdpvar(10,1);
%     for j =1:1:10
%         index=index+1;
%         gi(index,1)=MMat(j,k);
%     end
%     % Construct Nonlinear Vector
%     for fn=1:1:nT 
%         lm=0;
%         QW=G*Ga(fn,2); %--- ok
%         for ct=1:1:10
%             coe=1; lm=lm+1;
%             for l =1:1:n-1%length(Ga)
%                 coe=coe*Ga(fn,l)^(Mindez(ct,l)-1);
%             end
%             coe=coe*QW^(Mindez(ct,4)-1);
%             ff(lm,lm)=coe;
%         end
%         fnl2(fn,1)=Nc'*ff*gi; 
%     end
    %% From time domain back to frequency domain
    FFnl=Gp*(fnl1);
    Mfnl=[Mfnl;FFnl];
end