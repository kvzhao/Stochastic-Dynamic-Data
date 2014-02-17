function [f,PSD] = PSDScheme(s)
Fs = 100 ;                    % Sampling frequency
L = length(s) ;                     % Length of signal
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
y = fft(s) ;
PSD = 2*abs(y).^2/L/Fs ;
f = Fs/2*linspace(0,1,NFFT/2+1) ;
PSD = PSD(1:NFFT/2+1);
semilogx(f,PSD,'linewidth',2)
end
