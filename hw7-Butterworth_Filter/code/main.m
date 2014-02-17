clc ; close all ; 

dt = .1 ;  
Tfinal = 1000 ; 
t = 0 : dt : Tfinal ; 

num = 1; den = [2 1]; 
sys = tf( num,den ) ; 

std = 1; avg = 0 ; 
N = length( t ) ; 
% x = normrnd( avg , std, 1 , N ) ; 
% y = lsim( sys,x,t ) ;

MCS = 1000 ; 
ensemble = zeros( length(t), MCS ) ; 

for i=1:MCS 
    x = normrnd( avg , std, 1 , N ) ; 
    ensemble(:,i) = lsim( sys,x,t ) ;
end
ensemble = ensemble'; 
mu = mean( ensemble ) ;         

% plot(t,mu)