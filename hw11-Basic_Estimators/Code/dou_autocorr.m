function [ACFbiased,ACFunbiased, Lags] = dou_autocorr(x,nLags)
if nargin == 1
    nLags = 20 ;
end

Lags = 0:nLags ;

N = length(x) ;
ACFbiased = nan * zeros(1,nLags) ;
ACFunbiased = nan * zeros(1,nLags) ;

for r = 0:nLags
    xf = x(1:N-r) ;
    xr = x(1+r:N) ;
    ACFbiased(r+1) = sum(xf.*xr)/N ;
    ACFunbiased(r+1) = sum(xf.*xr)/(N-r) ;
end