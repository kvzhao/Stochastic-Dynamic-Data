function Psd = PsdFigure(s)

Fs = 1000 ;                    % Sampling frequency
T = 1/Fs ;                     % Sample time
L = 1000 ;                     % Length of signal
t = (0:L-1)*T ;                % Time vector

NFFT = 2^nextpow2(L); % Next power of 2 from length of y
y = fft(s) ;
Psd = 2*abs(y).^2/L/Fs ;

% PsddB = 10*log10(Psd(1:NFFT/2+1)) ;
f = Fs/2*linspace(0,1,NFFT/2+1) ;

% figure()
% pwelch(s,[],[],[],Fs)
% set(findobj('Type','line'),'linewidth',2,'Color','k')
% hold on
% plot(f,PsddB,'r')
plot(f,Psd(1:NFFT/2+1),'linewidth',2)

Psd = Psd(1:NFFT/2+1) ;