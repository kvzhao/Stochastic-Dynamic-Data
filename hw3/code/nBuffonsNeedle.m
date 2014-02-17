 %% Buffon's needle
function est_pi = fastBuffonsNeedle(N,d,l) 
     y = rand(N,1)*5*d ; 
     theta = rand(N,1) ; 
     
     dy = abs( .5*l*sin( 2*pi*theta ) ); 
     
     
     isTouch =floor(2*dy/d ); 
     
     r = sum( isTouch ) ; 

     % return the estimation value of pi 
     est_pi = 2*l*N/r/d ; 
   end