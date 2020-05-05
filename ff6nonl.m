function [fgnl]=ff6nonl(nAFT,n,MMat,nh,d,nT,w)

%% -------------------------------------------------------
[Ga,Gp]=f233sparse(nT,nh);
ri=2; rf=nfact(n,1); NMat=MMat(ri:rf,ri:rf); %sdisplay(NMat)
%% ------------------------------------------------------------------
[Nc]    =sin(2*pi);
for nc=1:1:nh
    Nc=[Nc;-w*nc;w*nc];
end
for nb=1:1:length(Nc)
    for nc=1:1:length(Nc)
        NN1(nb,nc)=Nc(nb,1)*Nc(nc,1);
    end
end
%% Construct a vector with redudant constraints
fgnl=[];
for k=1:1:1
    Mfnl1=[];
    %% Construct Nonlinear Vector
    for NT=1:1:nT
        % --------------------------- Trig Matrix -----
        Pc=sin(2*pi);        % ini ok
        for mc=1:1:nh
            Pc=[Pc;Ga(NT,2*mc+1);Ga(NT,2*mc)];
        end
        for pc=1:1:length(Pc)        % ini
            for pd=1:1:length(Pc)
                NNf(pd,pc)=Pc(pc,1)*Pc(pd,1);
            end
        end
        % ---------------------------
        FFnl=0; %NNf
        for m1=1:1:length(Nc)
            for m2=1:1:length(Nc)
                ffnl=NMat(m1,m2)*NN1(m1,m2)*NNf(m1,m2);
                FFnl=FFnl+ffnl;
            end
        end
        [cc,v] = coefficients(FFnl,NMat); 
        vec=flip(MMat(nfact(n,1)+1:nfact(n,2),k)); %sdisplay(vec)
        FFnl=cc'*vec;
        Mfnl1=[Mfnl1;FFnl];
    end
    %% Construct Nonlinear Vector
    Fnlf=Gp*(Mfnl1);
    fgnl=[fgnl;Fnlf];
end