function [Rxx Lags] = Autocorr(x,nLags)
if nargin == 1
    nLags = 20 ;
end
Lags = 0:nLags ;
N = length(x) ;
Rxx = nan * zeros(1,nLags) ;
for r = 0:nLags
    xf = x(1:N-r) ;
    xr = x(1+r:N) ;
%     Rxx(r+1) = sum(xf.*xr)/N ;
Rxx(r+1) = sum(xf.*xr)/(N-r);
end