function [p,xi] = dou_pdf(x,width)

% x_min = min(x) ;
% x_max = max(x) ;
x_min = -width ;
x_max = 1+width ;

 n = ceil((x_max-x_min)/width) ;
 
 x_interval = x_min + width * [0:n] ;
 xi = x_interval + 1/2 * width ;
 xi(end) = [] ;
 
 N = length(x) ;
 p = nan * ones(1,length(xi)-1) ;
 
 for i = 1:length(x_interval)-1
     n = length(find(x > x_interval(i) & x < x_interval(i+1))) ;
     p(i) = n/N/width ;
 end