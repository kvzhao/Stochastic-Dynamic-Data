clc  ; clear all ; close ; 
%% Random Number Generator 

n = 100 ;
r = lc_rand( n ) ;

plot(1:n,r) ; 

%% Random Number Generator 

n = 10 ; 

 m = 2^31 -1 ;
 k = 1 ; 
 a1 = 1385320287 ; 
 
 x = zeros( 1 , n) ; 
 
%  x(1)  = 1 ; 
seed  = clock() ; 
 x(1) = seed(6) ; 
 
for i = k : n-1 
    x( i +1) = mod(a1*x(i) , m) ; 
end

u = x/m ;