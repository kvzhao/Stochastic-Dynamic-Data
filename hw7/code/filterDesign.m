function TF = filterDesign( order ) 
    %% filter design 
    [z,p,k] = buttap(order) ;
    TF = zpk(z,p,k) ; 
    freq = 0.01:0.01:100 ;
    [mag,phase] = bode(TF,freq) ;
    MagdB(1,:) = 20*log10(mag(:)') ;

    figure() 
    semilogx( freq,MagdB(1,:) ,'linewidth',2) 
    grid on 
end