function [Ga,Gp]=f233sparse(nT,nh)

%nH=2*nh+1; % time samples
%Ga=zeros(nH,nH); Gp=zeros(nH,nH);

%% Gamma Matrix "DFT sparse operator"
for i=1:1:nT
    Ga(i,1)=1;
    for j=1:1:nh
    Ga(i,2*j)  =cos(j*i*2*pi/nT);
    Ga(i,2*j+1)=sin(j*i*2*pi/nT);
    end
end

%% Moore-Penrose PseudoInverse => Gp = G'*(G*G')^(-1)
for i=1:1:nT
    Gp(1,i)=(1/nT)*1*1;
    for j=1:1:nh
    Gp(2*j,i)  =(1/nT)*2*cos(j*i*2*pi/nT);
    Gp(2*j+1,i)=(1/nT)*2*sin(j*i*2*pi/nT);
    end
end

% Ga=round(Ga,15);
% Gp=round(Gp,15);