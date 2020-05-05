function [sumt]=f41sumdig(n)

% s = 0;                      %// initiallize output
% while n>0                   %// while there is some digit left
%     s = s + mod(n-1,10)+1;  %// sum rightmost digit
%     n = floor(n/10);        %// remove that digit
% end
% sumt=s;

sumt=sum(int2str(n)-48);