%% Random Number Generator 

function u = lc_rand2( n )
 m = 2^31 -1 ;
 
 % #1
k = 2 ; 
% a1 = 1498809829 ; 
% a2 = 1160990996 ;

 % 2
a1 = 46325 ; 
a2 = 1084587 ;

 x = zeros(1 , n) ; 
 
% the specific value for verifying the algorithm is deterministic
 x(1)  = 1 ; 
 x(2)  =  20; 
% Using system time as the seed
% seed  = clock() ; 
%  x(1) = seed(6) ; 
%  x(2) = seed(6) ; 
 
for i = k : n-k 
    x( i +2) = mod(a1*x(i)+a2*x(i+1) , m) ; 
end
u = x/m ;
end