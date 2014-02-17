function [f,NFFT] = my_FFT( y, Fs ,NFFT) 
    L = length(y);
%     NFFT = 2^nextpow2(L); % Next power of 2 from length of y
% NFFT = 1024 ;
    Y = fft(y,NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);
    Mag = abs(Y(1:NFFT/2+1)); 
    
    % Plot single-sided amplitude spectrum.
    figure()
%     plot(f,2*abs(Y(1:NFFT/2+1)),'LineWidth',1.5) 
    plot(f,20*log10(Mag),'LineWidth',1.5) 
    title('Single-Sided Amplitude Spectrum','fontsize',14)
    xlabel('Frequency (Hz)  (Linear Scale) ','fontsize',14)
%     ylabel('Magnitude |Y(f)|','fontsize',14);
    ylabel('Magnitude (dB) ','fontsize',14);
    grid on
    
    % Find Peak
    M = max(Mag);
    m = 20*log10(min(Mag));
    fmax = find( Mag == M ) ;
    M = 20*log10(M);
    hold on ; 
    plot([f(fmax),f(fmax)],[m,M],'--r','LineWidth',1.5);
    
    figure()
    semilogx(f,20*log10(Mag),'LineWidth',1.5);
    title('Single-Sided Amplitude Spectrum','fontsize',14)
    xlabel('Frequency (Hz)  (Log Scale) ','fontsize',14)
    ylabel('Magnitude |Y(f)|(dB)','fontsize',14);
    grid on
    
    % Plot phase
%     figure()
%     plot(f, angle(Y(1:NFFT/2+1)), '.-b'); grid on
%     xlabel('Frequency (Hz)  (Linear) ','fontsize',14)
%     ylabel('Phase (Radian)','fontsize',14);

end