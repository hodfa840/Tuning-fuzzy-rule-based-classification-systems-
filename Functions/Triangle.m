function [ Miu ] = Triangle( x , a , b , c )
    %compute mu of x in triangle(a,b,c)
    Miu = max(min((x-a)/(b-a) , (c-x)/(c-b)) , 0);

end

