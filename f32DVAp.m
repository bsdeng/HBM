function [sinp,cosp]=f32DVAp(N,t)
M=2*N;
%%
sinp=[0]; % sine in polynomial basis
for k=0:1:M
    sinp=sinp+(nchoosek(M,k)*t^(k))*((1i)^(M-k)-(-1i)^(M-k))/(2*1i); 
end
cosp=[0]; % cosine in polynomial basis
for k=0:1:M
    cosp=cosp+(nchoosek(M,k)*t^(k))*((1i)^(M-k)+(-1i)^(M-k))/(2);
end