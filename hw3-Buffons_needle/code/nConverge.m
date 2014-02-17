%% this program start from n ~ 1e3 to find pi estimation 
% set tolerance is 1%, as to say, pi_hat ~ 3.14 +- error
% with input L/D, tolerance ratio
function n = nConverge( r , error ) 
    n = 5e2; step = 1e2;
    tol = abs( pi - fastBuffonsNeedle(1,r) ) ;
    while tol > error
        tol = abs( pi - fastBuffonsNeedle(n,r) ) ; 
        n = n + step ; 
    end
end
