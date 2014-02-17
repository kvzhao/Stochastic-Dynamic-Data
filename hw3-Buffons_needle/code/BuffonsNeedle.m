 %% Buffon's needle
% N : numbers of needles
% a : length of space edge, but not a variable
%      we suppose the edge equals to 5 times of d
% d : line spacing
% l  : length of needle
function est_pi = BuffonsNeedle(N,d,l) 
if l > d 
    error( 'In the program, length of needle must less or equal to the spacing') ; 
   % random variables
end
     x = rand(N,1)*5*d ; 
     y = rand(N,1)*5*d ; 
     theta = rand(N,1) ; 
     
     dx = abs( .5*l*cos( 2*pi*theta ) ); 
     dy = abs( .5*l*sin( 2*pi*theta ) ); 
     xn = [ x+dx , x-dx] ;
     yn = [ y+dy  , y-dy ] ;
     
     yd = floor(yn/d) ; 
     isTouch = yd(:,1) - yd(:,2) ;
     r = sum( isTouch ) ; 
     p = r / N ; 
     % return the estimation value of pi 
     est_pi = 2*l/p/d ; 
     fprintf('The probability is : %f, estimated pi : %f\n', p ,est_pi) ;      
     %% plot
     if 1
         figure() ; 
         % grid
         fill([0 5*d 5*d 0],[0 0 5*d 5*d],'k','FaceColor','none','EdgeColor','k','linewidth',2)
         axis([-2 ,5*d+2, -2, 5*d+2])
         hold on 
        for i = 1 : 5
            plot([0 5*d],i*d*ones(1,2),'k','linewidth',2)
        end
        % needles 
        for i = 1:N
            if  isTouch(i) 
                plot(xn(i,:),yn(i,:),'r','linewidth',3)
            else
                 plot(xn(i,:),yn(i,:),'b','linewidth',3)       
            end
        end
     end
    
   end