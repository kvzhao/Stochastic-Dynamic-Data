function [f,spec] = my_PSD(s)

Fs = 100 ;                    % Sampling frequency
L= length(s);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
y = fft(s) ;
spec = 2*abs(y).^2/L/Fs ;

% PsddB = 10*log10(Psd(1:NFFT/2+1)) ;
f = Fs/2*linspace(0,1,NFFT/2+1) ;

% figure()
% pwelch(s,[],[],[],Fs)
% set(findobj('Type','line'),'linewidth',2,'Color','k')
% hold on
% plot(f,PsddB,'r')


% Psd = Psd(1:NFFT/2+1) ;