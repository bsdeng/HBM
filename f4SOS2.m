function [dm]=f4SOS2(x0d,x1d,t,nh,MMat,MMat1,n,po,E,d,par)

%alpha=par(1); beta=par(2); delta=par(3); w=par(4); G=par(5);

%% Compute the polynomial (SOS) distance
p1= po(1); p2= po(2); 
x2signal=-  E*((t^2+1)^nh)^2 ...
         +(x0d-p1*(t^2+1)^nh)^2;% ... 
        % +(x1d-p2*(t^2+1)^nh)^2; 
% Separate the given polynomial into two vectors (1) coef (2) variables
[cc,v] = coefficients(x2signal,MMat(1:nfact(n,d)));
% number of monomials for degree=2
de=2; epol=factorial(n+de)/(factorial(n)*factorial(de));
%% Find the degree of each monomial and convert them into single col vector
[mono]=mono_next_grlex_test(n,2); %sdisplay(mono)
for k=1:1:length(mono)
    mon1(k,1)=0;
    for n1=1:1:n
        mon=mono(k,n1)*10^(n1-1);
        mon1(k,1)=mon1(k,1)+mon;
    end
    mon1(k,1)=mon1(k,1)-111; %$ ------------------------------------------
end
mon1n=mon1(1:epol,1);
newv=[];
for k=1:1:length(v)
    degg=degree(v(k,1),MMat1);
    newv=[newv;degg];
end
%
for k=1:1:length(newv)
    mon2(k,1)=0;
    for n1=1:1:n
        mon=newv(k,n1)*10^(n-n1);
        mon2(k,1)=mon2(k,1)+mon;
    end
end
%% Substitute all squared monomials into respective linear monomials
%  In addition, put them in the correct order
cl2=factorial(n+2)/(factorial(n)*factorial(2));
cl1=factorial(n+1)/(factorial(n)*factorial(1));
cl2m=cl1+1;  cl1m=2;    %cl2m
cl2M=cl2;    cl1M=cl1;  %cl2M
cl2mod=cl2m;
for cs=length(v):-1:1
    sumdig=f41sumdig(mon2(cs,1));
    if sumdig == 2 %% quadratic monomials
        if mon2(cs,1) == mon1n(cl2,1)
            Ms(cs,1)=MMat(cl2mod,1);
        else
            cl2=cl2-1; cl2mod=cl2mod+1;
            if mon2(cs,1) == mon1n(cl2,1)
                %
                cl2v=cl2m+cl2M-cl2;
                %sdisplay(MMat(cl2v,1))
                Ms(cs,1)=MMat(cl2v,1);
                %
            end
        end
        cl2=cl2-1; cl2mod=cl2mod+1;
    end
    if sumdig == 1 %% linear monomials
        if mon2(cs,1) == mon1n(cl1,1)
            %
            cl1v=cl1m+cl1M-cl1;
            Ms(cs,1)=MMat(cl1v,1);
            %
        end
        cl1=cl1-1;
    end
    if sumdig == 0 %% constant number
        Ms(cs,1)=1;
    end
end
%% Construct the SOS matrix through SOS decomposition
x2signal=Ms'*cc;
newv=Ms;
model=sos(x2signal);
options = sdpsettings('sos.newton',0,'verbose',0,'sos.congruence',0);
[FG,objective,monomials] = sosmodel(model,-[newv;E],options,[newv;E]); 
dm=sdpvar(FG{1}); %cm=sdpvar(monomials{1});