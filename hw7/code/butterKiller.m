function butter_sys = butterKiller( order )
%%====================================================================================
%%====================================================================================
%     order = 5 ; 
    [z,p,k] = buttap( order ) ;
    butter_sys = zpk(z,p,k); 

    n = 1e4; 
    w = wgn(n,1,0) ; 
    N = 2048; 
    fs = 8000;			
%     myfft( w,fs,N ) ; 
    y = lsim(butter_sys,w,0:n-1) ; 
    myfft(y,fs,N ) ; 
end

