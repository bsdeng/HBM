function x = mono_next_grlex(m,x)

i = 0;
for j = m : -1 : 1
    if ( 0 < x(j) )
        i = j;
        break
    end
end

if ( i == 0 )
    x(m) = 1;
    return
elseif ( i == 1 )
    t = x(1) + 1;
    im1 = m;
elseif ( 1 < i )
    t = x(i);
    im1 = i - 1;
end
x(i) = 0;
x(im1) = x(im1) + 1;
x(m) = x(m) + t - 1;
return
end