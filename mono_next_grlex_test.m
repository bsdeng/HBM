function [mono]=mono_next_grlex_test(n,d)

k = 1;
x = zeros (n,1); 
mono(1,:)=ones(n,1); % mod
while ( 1 )
    if ( x(1) == d )
        break
    end
    k = k + 1;
    x = mono_next_grlex (n,x);
    mono(k,:)=fliplr(x(1:n)')+ones(1,n); % mod
end
return
end

