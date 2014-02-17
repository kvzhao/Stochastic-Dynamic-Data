function z = gaussian_dist( n ) 
    z = sqrt( -2*log(rand(n,1) ) ).*cos(2*pi*rand(n,1) ) ; 
%     r = sigma*z + mu ; 
end