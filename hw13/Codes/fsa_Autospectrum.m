function Gxx = fsa_Autospectrum(Be,fc,y)
    k = 1; % Gain of NBP
    H = tf( [k,0] , [1,2*pi*Be,pi^2*(Be^2+4*fc^2)] );
    % Always suppose sampling rate is 1Hz
    fs = 1 ; 
    T = length(y);
    t = (0:T-1)/fs;
    
    x = lsim(H,y,t);
    x = abs(x).^2 ; 
    
%     Gxx = ;
end