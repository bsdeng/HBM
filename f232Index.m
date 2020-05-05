function [Mindex]=f232Index(n,d)

d=2*round(d/2);
%%
[mono]=mono_next_grlex_test(n,d);
for k=1:1:length(mono)
    mon1(k,1)=0;
    for n1=1:1:n
        mon=mono(k,n+1-n1)*10^(n1-1);
        mon1(k,1)=mon1(k,1)+mon;
    end
end
%%
for k=0:1:d
    col(k+1,1)=factorial(n+k)/(factorial(n)*factorial(k));
end
for k=1:1:d %d
    ci=col(k,1)+1;
    cf=col(k+1,1);
    mon1(ci:cf,1)=sort(mon1(ci:cf,:),'descend'); %sdisplay(mon1(ci:cf))
end
%%
for k=1:1:length(mon1)
    b=dec2base(mon1(k,1),10) - '0';
    mon2(k,:)=b;
end
%%
Mindex=mon2;