%% --- This simulation is performed using: ------------------------------ %
% Matlab R2015b       % Mac Mini 2014 late
% Yalmip - v.20170626 % Sedumi - v.1.32   
% --- Author: B. S. Deng - version 4.0 - July. 13, 2019 --------- %
close all; clc; clear; warning('off','all'); format short; hold on; %tic; 
%% -- 11111111111111111111111111111111111   ----------------------------- %
alpha = -1/2; delta=1/2; beta=1; w=1; FF=1; 
nh=1; nT=2^7; %nT=5+4*(nh-1);
%tic
[par,ep,d,po,n,nAFT]=f1NLFsys(alpha,beta,delta,w,FF,nh,nT); nAFT=n; %po
%ad=toc
[dnh1]=algo1(par,nAFT,n,nh,d,FF,nT,po); %PPHBMduf(dMat,w); ---
PPHBMduf(dnh1,w,nh); % -------------------------------------------
%et=toc
fname = sprintf('myfile%d.mat', nh); save(fname)