function [x0d,x1d,MMat1] =f3DVA(t,n,MMat,nh,par)

[Ia,Ib]=f31DVAg(n);
% Construct trigonometric column vectors in polynomial basis
triM(1,1)=(t^2+1)^nh;
for k=1:1:nh
    [sinp,cosp]=f32DVAp(k,t);
    cosM=[cosp*(t^2+1)^(nh-k)]; sinM=[sinp*(t^2+1)^(nh-k)];
    triM=[triM;cosM;sinM];
end
% Coefficients of the polynomial
MMat1=[MMat(2,1)];
for k=1:1:nh
    if k==1
        MMat1=[MMat1 MMat(2*k+1,1) MMat(2*k+2,1)];
    else
        MMat1=[MMat1 MMat(2*k+1,1) MMat(2*k+2,1)];
    end
end
% Constructing the state and the distance
x0d= MMat1*Ia*triM; 
x1d= MMat1*Ib*triM; 