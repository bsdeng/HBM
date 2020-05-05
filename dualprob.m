close all; clc; clear;

% Primal Problem
%     max. b'*y
%     s.t. C - sum{Ai*yi} >= 0
%          sum{Gi*yi} == f
%
% Dual Problem
%     min. C*X + f'*t
%     s.t. Ai*X + Gi'*t = bi
%          X >= 0

X = sdpvar(30,30);
Y = sdpvar(3,3);
obj = trace(X)+trace(Y);
F = [X>=0, Y>=0];
F = [F, X(1,3)==9, Y(1,1)==X(2,2), sum(sum(X))+sum(sum(Y)) == 20]

[Fd,objd,primals] = dualize(F,obj);Fd

optimize(Fd,-objd);
for i = 1:length(primals);assign(primals{i},dual(Fd(i)));end

optimize(Fd,-objd);

%

X = sdpvar(2,2);
t = sdpvar(2,1);
Y = sdpvar(3,3);
obj = trace(X)+trace(Y)+5*sum(t);

F = [sum(X) == 6+pi*t(1), diag(Y) == -2+exp(1)*t(2)]
F = [F, Y>=0, X>=0];

optimize(F,obj);
value(t)

[Fd,objd,primals,free] = dualize(F,obj);Fd

optimize(Fd,-objd);
assign(free,dual(Fd(end)))
value(t)

optimize(F,obj,sdpsettings('dualize',1));
value(t)
