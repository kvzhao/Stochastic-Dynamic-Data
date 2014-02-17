%% Random Number Generator 

function u = lc_rand( n )
 m = 2^31 -1 ;
 
 k = 1 ;  
% #1
%  a1 = 1385320287 ; 
%2 
 a1 = 41358 ; 
 x = zeros( 1 , n) ; 

% the specific value for verifying the algorithm is deterministic
 x(1)  = 1 ; 

% Using system time as the seed
% seed  = clock() ; 
%  x(1) = seed(6) ; 

for i = k : n-k 
    x( i +1) = mod(a1*x(i) , m) ; 
end
u = x/m ;
end