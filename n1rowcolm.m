function [MMat,j]=n1rowcolm(MMat,krini,krend,kcini,kcend,M,jini)

j=jini;
for kr=krini:1:krend
    MMat(kr,kcini)=M(j);
    j=j+1;
end
j=jini;
for kc=kcini:1:kcend
    MMat(krini,kc)=M(j);
    j=j+1;
end