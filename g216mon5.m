function [MMat]=g216mon5(MMat,counter,n,drelax,d,M)

%% jini  jend  --- 
jcum=0; nn=n+1-counter; dd=drelax-1;
if counter >= 2
    for k=2:1:counter
        jcum=(factorial(n+2-k+dd)/(factorial(n+2-k)*factorial(dd)))+jcum;
    end
end
jini=factorial(nn+4)/(factorial(nn)*factorial(4))+jcum+1; %sdisplay(jini)
jend=factorial(nn+5)/(factorial(nn)*factorial(5))+jcum;   %sdisplay(jend)
%% krini krend --- rows
krini=1;
for k=1:1:counter
    krini=(factorial(n+1-k+2)/(factorial(n+1-k)*factorial(2)))+krini;
end
%sdisplay(krini)
krend=factorial(n+3)/(factorial(n)*factorial(3)); %sdisplay(krend)
%% kcini kcend --- columns
jcum=0;
kcini=factorial(n+1-counter+1)/(factorial(n+1-counter)*factorial(1))+1;
if counter >= 2
    for k=2:1:counter
        jcum=(factorial(n+2-k+2)/(factorial(n+2-k)*factorial(2)))+jcum;
    end
end
kcini=kcini+jcum; %sdisplay(kcini)
jcum=0;
kcend=factorial(n+2)/(factorial(n)*factorial(2));
if counter >= 2
    for k=2:1:counter
        jcum=(factorial(n+1-k+2)/(factorial(n+1-k)*factorial(2)))+jcum;
    end
end
kcend=kcend+jcum; %sdisplay(kcend)
%% Matrice Location ---
                                        % - 0v.1v.2v
                                        % - 1v.2s.3r
                                        % - 2v.3r.4s
                                        % - 3v.4r.RR
% Total
krii=krini; krei=krend;
kcii=kcini; kcei=kcend;
m=n-counter; o=n;
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
    k3rri=krini+m+1;          k3ori=k3rri; %sdisplay(k3rri)
    k3rre=krini+nfact(m,2)-1; k3ore=k3rre; %sdisplay(k3rre)
    k3rci=kcini+1;            k3oci=k3rci; %sdisplay(k3rci)
    k3rce=kcini+m;            k3oce=k3rce; %sdisplay(k3rce)
    % --- rectangular d==3T ---
    %33
    k3tri=krini+1;            %sdisplay(k3tri)
    k3tre=krini+m;            %sdisplay(k3tre)
    k3tci=kcini+m+1;          %sdisplay(k3tci)
    k3tce=kcini+nfact(m,2)-1; %sdisplay(k3tce)
    % --- rectangular d==4 ---
    %4
    k4rri=krini+nfact(m,2);   %sdisplay(k4rri)
    k4rre=krend;              %sdisplay(k4rre)
    k4rci=kcini+1;            %sdisplay(k4rci)
    k4rce=kcini+m;            %sdisplay(k4rce)
    % --- symmetric d==4 ---
    %44
    k4sri=krini+m+1;          %sdisplay(k4sri)
    k4sre=krini+nfact(m,2)-1; %sdisplay(k4sre)
    k4sci=kcini+m+1;          %sdisplay(k4sci)
    k4sce=kcend;              %sdisplay(k4sce)
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
        k1i=s3rri; k1e=s3rre;
        k2i=s3rci; k2e=s3rce;
        if k1e-k1i >= 0
            MMat(k1i:k1e,k2i:k2e)=Sym;
        end
        end
        %% --- update ---
        o=o-1;
        k3rri=k3rri+o+1+1-counter; %sdisplay(k3rri)
        k3rci=k3rci+1;   %sdisplay(k3rci)
    end
    MMat(k3tri:k3tre,k3tci:k3tce)=MMat(k3ori:k3ore,k3oci:k3oce)';
    %% --- rectangular d==4 ---                problem up here
    o=n-1; jrini=jini;
    for contar1=counter:1:n-1
        %% --- row/col ---
        jrini=jrini+nfact(o+1-counter,3);
        [MMat,j]=n1rowcolm(MMat,k4rri,k4rre,k4rci,k4rce,M,jrini); % row/col
        if o-counter >= 0
        %% --- sym -------
        jtini=jrini; p=o-counter; %o-1;
        s4rri=k4rri+1; %sdisplay(s4rri) % --- sym
        s4rre=k4rri+p; %sdisplay(s4rre)
        s4rci=k4rci+1; %sdisplay(s4rci)
        s4rce=k4rci+p; %sdisplay(s4rce)
        % ---
        j=jrini+o+1-counter;%-contar1+1;
        k1e=s4rre-s4rri+1; k2e=s4rce-s4rci+1; ns=0;
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
        k1i=s4rri; k1e=s4rre;
        k2i=s4rci; k2e=s4rce;
        if k1e-k1i >= 0
            MMat(k1i:k1e,k2i:k2e)=Sym;
        end
        %% --- rec -------
        jtini=jrini+nfact(p,2);   %display(jtini)
        r4rri=k4rri+nfact(p,1);   %sdisplay(r4rri) % --- sym
        r4rre=k4rri+nfact(p,2)-1; %sdisplay(r4rre)
        r4rci=k4rci+1;            %sdisplay(r4rci)
        r4rce=k4rci+p;            %sdisplay(r4rce)
        q=o-1; qq=q; %qa=q-counter;
        q=q-counter; % ------------------------------------
        for contar2=counter:1:n-2
            [MMat,j]=n1rowcolm(MMat,r4rri,r4rre,r4rci,r4rce,M,jtini); %q=o-1;
            if q >= 1 % p >= 0
                % --- sym -------
                %q=q-counter;  %q=o-2
                ssrri=r4rri+1;%+contar2-counter; %sdisplay(ssrri) % --- sym
                ssrre=r4rri+q; %sdisplay(ssrre)
                ssrci=r4rci+1;%+contar2-counter; %sdisplay(ssrci)
                ssrce=r4rci+q; %sdisplay(ssrce)
                % ------------------
                j=jtini+nfact(qq,1)+counter-contar2-counter; %o-counter;%-contar1+1;
                k1e=ssrre-ssrri+1;
                k2e=ssrce-ssrci+1;
                ns=0;
                % k1e
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
                    %sdisplay(Sym)
                end
                k1i=ssrri; k1e=ssrre;
                k2i=ssrci; k2e=ssrce;
%                 sdisplay(Sym)
%                 sdisplay(k1i)
%                 sdisplay(k1e)
%                 sdisplay(k2i)
%                 sdisplay(k2e)
                if k1e-k1i >= 0
                    MMat(k1i:k1e,k2i:k2e)=Sym;
                end
            end
            % -- update
            if p-1 >= 0
            p=p-1; q=q-1;
            jtini=jtini+nfact(p,2); %display(jtini)
            r4rri=r4rri+nfact(p,1); %sdisplay(r4rri) % --- sym
            r4rci=r4rci+1;          %sdisplay(r4rci)
            end
        end
        end
        %% --- update ---
        o=o-1;
        k4rri=k4rri+nfact(o+1-counter,2);
        k4rci=k4rci+1;
    end
    %% --- symmetric   d==4 -------------------------------------------------------------------------
    o=m; jrini=jini;
    for contar1=counter:1:n-1
        % --- row/col ===
        jrini=jrini+nfact(o,3);
        [MMat,j]=n1rowcolm(MMat,k4sri,k4sre,k4sci,k4sce,M,jrini); 
        %sdisplay(n-counter)
        if n-counter >= 2 %o-counter >= 0
        % --- sym =======
        j=jrini-1+nfact(o,1); p=o-1; % ****
        s4sri=k4sri+1; s4sre=k4sri+p; s4sci=k4sci+1; s4sce=k4sci+p;
        k1e=s4sre-s4sri+1; k2e=s4sce-s4sci+1; ns=0;
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
        k1i=s4sri; k1e=s4sre;
        k2i=s4sci; k2e=s4sce;
        if k1e-k1i >= 0
            MMat(k1i:k1e,k2i:k2e)=Sym;
        end
        %[MMat,k1e,k2e,j]=n2symm(MMat,jtini,o,counter,M,j,s4sri,s4sre,s4sci,s4sce); 
        % --- rec =======
        jtini=jrini+nfact(p,2);   %sdisplay(jtini)
        r4rri=k4sri+o;            r4ori=r4rri; %sdisplay(r4rri) % --- sym
        r4rre=k4sri+nfact(p,2)-1; r4ore=r4rre; %sdisplay(r4rre)
        r4rci=k4sci+1;            r4oci=r4rci; %sdisplay(r4rci)
        r4rce=k4sci+p;            r4oce=r4rce; %sdisplay(r4rce)
        r4tri=k4sri+1;            
        r4tre=k4sri+p; 
        r4tci=k4sci+o;            
        r4tce=k4sci+nfact(p,2)-1;   
        for contar2=counter:1:n-2
            for contar3=1:1:p
                [MMat,j]=n1rowcolm(MMat,r4rri,r4rre,r4rci,r4rce,M,jtini);
                %sdisplay(o-counter)
                if o-counter >= 0 % **** 1
                    % --- sym -------
                    q=o-1-contar3;
                    ssrri=r4rri+1; %sdisplay(ssrri) % --- sym
                    ssrre=r4rri+q; %sdisplay(ssrre)
                    ssrci=r4rci+1; %sdisplay(ssrci)
                    ssrce=r4rci+q; %sdisplay(ssrce)
                    j=jtini+nfact(q,1);%jtini+o-counter+1+counter-contar2; %jtini+o-counter;%-contar1+1;
                    k1e=ssrre-ssrri+1; k2e=ssrce-ssrci+1; ns=0;
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
                    k1i=ssrri; k1e=ssrre; k2i=ssrci; k2e=ssrce;
                    if k1e-k1i >= 0
                        MMat(k1i:k1e,k2i:k2e)=Sym;
                    end
                end
                % -- update
                p=p-1;
                jtini=jtini+nfact(p,2); %sdisplay(jtini)
                r4rri=r4rri+nfact(p,1); %sdisplay(r4rri) % --- sym
                r4rci=r4rci+1; %sdisplay(r4rci)
            end
        end
        if r4tre >= r4tri
        MMat(r4tri:r4tre,r4tci:r4tce)=MMat(r4ori:r4ore,r4oci:r4oce)';
        end
        %% --- update ---
        o=o-1;
        k4sri=k4sri+nfact(o,1);
        k4sci=k4sci+nfact(o,1);
        end
    end
    %% --- update ---------------------------------------------------------
    n=n-1; m=m-1;
    jini =nfact(n+1-counter,4)+jini;  %display(jini)
    krini=nfact(n+1-counter,2)+krini; %display(krini)
    kcini=nfact(n+1-counter,1)+kcini; %display(kcini)
    end
end

%% display the obtained matrix in the interval
MMat(kcii:kcei,krii:krei)=MMat(krii:krei,kcii:kcei)';

%sdisplay(MMat(krii:krei,kcii:kcei))
%sdisplay(MMat(kcii:kcei,krii:krei))