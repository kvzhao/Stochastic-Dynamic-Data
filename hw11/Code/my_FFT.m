function my_FFT( y, Fs ) 
    L = length(y);
    NFFT = 2^nextpow2(L); % Next power of 2 from length of y
    Y = fft(y,NFFT)/L;
    f = Fs/2*linspace(0,.1,NFFT/2+1);

    % Plot single-sided amplitude spectrum.
    figure()
    plot(f,2*abs(Y(1:NFFT/2+1)),'LineWidth',1.5) 
    title('Single-Sided Amplitude Spectrum','fontsize',14)
    xlabel('Frequency (rad/sec)  (Linear) ','fontsize',14)
    ylabel('Magnitude |Y(f)|','fontsize',14);
    grid on
    
    % Plot phase
    figure()
    plot(f, angle(Y(1:NFFT/2+1)), '.-b'); grid on
    xlabel('Frequency (Hz)  (Linear) ','fontsize',14)
    ylabel('Phase (Radian)','fontsize',14);

end