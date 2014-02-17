%% the program can find the convergent number of N
function n = nConverge( goal, mu, dev, error ) 
    n = 1e1; step = 1e1; 
    switch goal 
        case 'mean'
             tol = 1;
            while tol > error
                tol = abs( mu - mean( normrnd( mu,dev,n,1) ) ) ; 
                n = n + step ; 
            end
        case 'deviation'
              tol = 1;
            while tol > error
                tol = abs( dev - std( normrnd( mu,dev,n,1 ) ) ) ; 
                n = n + step ;
            end
    end
end
