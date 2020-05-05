function [par,ep,d,po,n,nAFT]=f1NLFsys(alpha,beta,delta,w,FF,nh,nT)

par=[alpha beta delta w]; % create a vector w/ all parameter values

x=sdpvar(2,1); 
L=[0 1;-alpha -delta]; nlf=[0;-beta*x(1,1)^3]; 
xd=L*x+nlf; d=degree(xd); % determine the dynamical system degree

xe=sqrt(-alpha/beta); ye=0; 
ep=[xe;ye];               % calculate its equilibrium points

f=@(t,x)[x(2);
         -alpha*x(1)-delta*x(2)-beta*x(1)^3+FF*cos(w*t)];
% Run ode45
tspan = linspace(0,20*pi,10*nT+1); %0:0.01:100;
[t,x] = ode45(f,tspan,[-1.65 0]); 
grid on; hold on; 
ti=round(0.9*length(t)); tf=length(t); xout=[x(ti:tf,:) t(ti:tf,:)];
scatter(x(ti:tf,1),x(ti:tf,2)); plot(x(ti:tf,1),x(ti:tf,2)); 
xlabel('\it x','FontSize',30); ylabel('\it y','FontSize',30); 
set(0,'defaulttextinterpreter','latex'); set(gca,'fontsize',18);
title('Phase Portrait - Duffing Oscillator','FontSize',18); 
axis square equal

for k=ti:1:tf
    if (x(k,1)) <= 0.49
        po(1)=x(k,1);
        po(2)=x(k,2);
    end
end                       % determine the data points of the system

n=(2*nh)+1;               % total number of Fourier coefficients

nAFT=nfact(n,d);          % number of redundant groups of constraints