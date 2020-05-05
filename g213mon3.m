function [MMat]=g213mon3(MMat,nc,counter,M,n,d,drelax)

%% jini and jend
jcum=0;
jini=factorial(n+1-counter+2)/(factorial(n+1-counter)*factorial(2))+1;
jend=factorial(n+1-counter+3)/(factorial(n+1-counter)*factorial(3));
if counter >= 2
    for k=2:1:counter
    jcum=factorial(n+2-k + drelax-1)/(factorial(n+2-k)*factorial(drelax-1))+jcum;
    end
end
jini=jini+jcum; %sdisplay(jini)
jend=jend+jcum; %sdisplay(jend)
%% krini and krend
krcum=0;
krini=factorial(n+1-counter+1)/(factorial(n+1-counter)*factorial(1))+1;
krend=factorial(n+1-counter+2)/(factorial(n+1-counter)*factorial(2));
if counter >= 2
    for k=2:1:counter
        krcum=factorial(n+2-k + 2)/(factorial(n+2-k)*factorial(2))+krcum;
    end
end
krini=krini+krcum; %sdisplay(krini)
krend=krend+krcum; %sdisplay(krend)
%% kcini and kcend
kccum=0;
kcini=2;
kcend=factorial(n+1-counter + 1)/(factorial(n+1-counter)*factorial(1));
if counter >= 2
    for k=2:1:counter
        kccum=factorial(n+2-k + 2)/(factorial(n+2-k)*factorial(2))+kccum;
    end
end
kcini=kcini+kccum; %sdisplay(kcini)
kcend=kcend+kccum; %sdisplay(kcend)
%% Matrice Location ---
                                        % - 0v.1v
                                        % - 1v.2s
                                        % - 2v.RR
% Total
krii=krini; krei=krend;
kcii=kcini; kcei=kcend;
m=n-1+1-counter;
%%
for ct=counter:1:n
    % --- symmetric d==2 ---
    %2
    k2sri=krini+1; %sdisplay(k2sri)
    k2sre=krini+m; %sdisplay(k2sre)
    k2sci=kcini+1; %sdisplay(k2sci)
    k2sce=kcini+m; %sdisplay(k2sce)
    %% --- row column  d==1 ---
    [MMat,j]=n1rowcolm(MMat,krini,krend,kcini,kcend,M,jini); % row/column
    %% --- symmetric   d==2 ---
    [MMat,k1e,k2e]=n2symm(MMat,jini,n,counter,M,j,k2sri,k2sre,k2sci,k2sce); % sym
    %% --- update ---------------------------------------------------------
    n=n-1; m=m-1;
    jini =factorial(n+1-counter + 2)/(factorial(n+1-counter)*factorial(2))+jini;  %display(jini)
    krini=factorial(n+1-counter + 1)/(factorial(n+1-counter)*factorial(1))+krini; %display(krini)
    kcini=factorial(n+1-counter + 0)/(factorial(n+1-counter)*factorial(0))+kcini; %display(kcini)
end

%% display the obtained matrix in the interval
MMat(kcii:kcei,krii:krei)=MMat(krii:krei,kcii:kcei)';

%sdisplay(MMat(krii:krei,kcii:kcei))
%sdisplay(MMat(kcii:kcei,krii:krei))