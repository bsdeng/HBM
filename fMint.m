function [ni,nf]=fMint(n,d)

ni=factorial(n+d-1)/(factorial(n)*factorial(d-1))+1;
nf=factorial(n+d)/(factorial(n)*factorial(d));