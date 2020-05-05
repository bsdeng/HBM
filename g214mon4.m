function [MMat]=g214mon4(MMat,counter,n,drelax,M)

%% jini and jend
jcum=0; 
jini=factorial(n+1-counter+3)/(factorial(n+1-counter)*factorial(3))+1;
jend=factorial(n+1-counter+4)/(factorial(n+1-counter)*factorial(4));
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
kcini=krini; %sdisplay(kcini)
kcend=krend; %sdisplay(kcend)
%% Matrice Location ---
                                        % - 0v.1v.2v
                                        % - 1v.2s.3r
                                        % - 2v.3r.RR
% Total
%sdisplay(jini)
krii=krini; krei=krend; %sdisplay(krii)
kcii=kcini; kcei=kcend; %sdisplay(kcii)
m=n-counter; o=n;%n=n+1-counter;
%%
for ct=counter:1:n
    % --- symmetric d==2 ---
    %2
    k2sri=krini+1; %sdisplay(k2sri)
    k2sre=krini+m; %sdisplay(k2sre)
    k2sci=kcini+1; %sdisplay(k2sci)
    k2sce=kcini+m; %sdisplay(k2sce)
    % --- rectangular d==3 ---
    %3
    k3rri=krini+m+1;          %sdisplay(k3rri)
    k3rre=krini+nfact(m,2)-1; %sdisplay(k3rre)
    k3rci=kcini+1;            %sdisplay(k3rci)
    k3rce=kcini+m;            %sdisplay(k3rce)
    % --- rectangular d==3T ---
    %33
    k3tri=krini+1;            %sdisplay(k3tri)
    k3tre=krini+m;            %sdisplay(k3tre)
    k3tci=kcini+m+1;          %sdisplay(k3tci)
    k3tce=kcini+nfact(m,2)-1; %sdisplay(k3tce)
    %% --- row column  d==1 ---
    [MMat,j]=n1rowcolm(MMat,krini,krend,kcini,kcend,M,jini); % row/column
    if counter < n
    %% --- symmetric   d==2 ---
    [MMat,k1e,k2e]=n2symm(MMat,jini,n,counter,M,j,k2sri,k2sre,k2sci,k2sce); % sym
    %% --- rectangular d==3 ---
    o=n-1; jrini=jini;
    for contar1=counter:1:n
        jrini=jrini+nfact(o+1-counter,2);
        [MMat,j]=n1rowcolm(MMat,k3rri,k3rre,k3rci,k3rce,M,jrini); % row/col
        if m>=0
        p=o-counter;
        s3rri=k3rri+1; %sdisplay(s3rri) % --- sym
        s3rre=k3rri+p; %sdisplay(s3rre)
        s3rci=k3rci+1; %sdisplay(s3rci)
        s3rce=k3rci+p; %sdisplay(s3rce)
        % ------------------
        j=jrini+o+1-counter;%-contar1+1;
        k1e=s3rre-s3rri+1; k2e=s3rce-s3rci+1; ns=0;
        if k1e >= 1
            Sym=sdpvar(k1e);
            for k1=1:1:k1e
                for k2=1+ns:1:k2e
                    Sym(k1,k2)=M(j);
                    if k1 ~= k2
                        Sym(k2,k1)=M(j); 
                    end
                    j=j+1;
                end
                ns=ns+1;
            end
        end
        k1i=s3rri; k1e=s3rre; k2i=s3rci; k2e=s3rce;
        if k1e-k1i >= 0
            MMat(k1i:k1e,k2i:k2e)=Sym;
        end
        end
        %% --- update ---
        o=o-1;
        k3rri=k3rri+o+1+1-counter; %sdisplay(k3rri)
        k3rci=k3rci+1;   %sdisplay(k3rci)
    end
    MMat(k3tri:k3tre,k3tci:k3tce)=MMat(k3tci:k3tce,k3tri:k3tre)';
    end
    %% --- update ---------------------------------------------------------
    n=n-1; m=m-1;
    jini =nfact(n+1-counter,3)+jini;  %sdisplay(jini)
    krini=nfact(n+1-counter,1)+krini; %sdisplay(krini)
    kcini=nfact(n+1-counter,1)+kcini; %sdisplay(kcini)    
end

%% display the obtained matrix in the interval
%sdisplay(MMat(krii:krei,kcii:kcei))