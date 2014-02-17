function my_Gxx( Rxx, Fs ) 
    L = length(Rxx);
    NFFT = 2^nextpow2(L); % Next power of 2 from length of y
    Sxx = fft(Rxx,NFFT)/L;
    
    f = Fs/2*linspace(0,1,NFFT/2+1);

    % Plot single-sided amplitude spectrum.
    figure()
    offset = 10*log10(2);
    plot(f,10*log10(abs(Sxx(1:NFFT/2+1) ) )+offset,'LineWidth',1.5) 
    
%      plot(f,abs(Y(1:NFFT/2+1) ) ,'LineWidth',1.5) 

    title('Single-Sided Power Spectrum','fontsize',14)
    xlabel('Frequency (Hz)  (Linear) ','fontsize',14)
%     ylabel('Magnitude |Y(f)|','fontsize',14);
    ylabel('Magnitude (dB) ','fontsize',14);
    grid on
end