 %% Buffon's needle
function est_pi = fastBuffonsNeedle(N,rr)  
     y = rand(N,1)*5;      
     theta = rand(N,1) ;     
     dy = abs( .5*rr*sin( 2*pi*theta ) ); 
     yn = [ y+dy  , y-dy ] ;     
     yn= floor(yn) ; 
     yn(:,1) = yn(:,1) - yn(:,2) ;
     r = sum( yn(:,1) ) ; 
     % return the estimation value of pi 
      est_pi = rr*N/r << 2 ; 
   end