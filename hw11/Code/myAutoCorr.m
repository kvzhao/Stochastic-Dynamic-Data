function [ACF,lags] = myAutoCorr(x,nLag,version)

if nargin == 1 
    nLag= 20;
    version = 'unbiased';
end
 if nargin == 2 
        version = 'unbiased';
 end

N = length( x );
ACF = zeros(1,nLag);   
lags = 0 : nLag; 

 switch(version)
    case 'biased'
        for r = 0 : nLag 
            xf = x(1:N-r) ;
            xr = x(1+r:N) ;
            ACF(r+1) = sum(xf.*xr)/N ;
        end
    case 'unbiased'
        for r = 0 : nLag 
           xf = x( 1 : N-r );
           xr = x( 1+r : N);
          ACF(r+1) = sum(xf.*xr)/(N-r) ;
        end
 end
end