function []=PPHBMduf(dMhar,w,nh)

Q=0.02*pi*w;
for t=0.0001:0.0001:2
    ni=round(t*10000);
    for k=1:1:nh
    x (ni,1)=dMhar(1)+(+dMhar(2*nh)  *cos(Q*ni)+dMhar(2*nh+1)*sin(Q*ni));
    xd(ni,1)=        +(-dMhar(2*nh)*w*sin(Q*ni)+dMhar(2*nh+1)*w*cos(Q*ni));
    end
end
set(0,'DefaultFigureWindowStyle','docked')

figure(01)
plot(x(1900:1:2000,1),xd(1900:1:2000,1),'color','g')
legend('sparse','ode45','HBM'); 
