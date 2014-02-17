function [f,Mag] = my_FFTv(y) 
    L = length(y);
    Fs = 100; 
    NFFT = 2^nextpow2(L); 
    Y = fft(y,NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);
    Mag = abs(Y(1:NFFT/2+1)); 
%     figure()
%     semilogx(f,20*log10(Mag),'LineWidth',1.3);
%     semilogx(f,Mag,'LineWidth',1.3);
%     title('Single-Sided Amplitude Spectrum','interpreter','latex','fontsize',14)
%     xlabel('Frequency (Hz)  (Log Scale) ','interpreter','latex','fontsize',14)
%     ylabel('Amplitude $|Y(f)|$','interpreter','latex','fontsize',14);
%     grid on; axis tight
end