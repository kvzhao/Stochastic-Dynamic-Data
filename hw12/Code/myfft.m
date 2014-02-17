function myfft( x ) 
% FFT setting 
  L = length(x) ; 
  N = 2^nextpow2(L);
  fs = 1e4;	% in Hz
  
  freqStep = fs/N;		

% f = 10*freqStep;		
% time = (0:N-1)/fs;		

y = x(1:N) ; 
Y = fft(y);			
Y = fftshift(Y);		

% Plot time data

% subplot(2,1,1);
% figure() ;
% plot(time, y, '.-');
% title('Signals','fontsize',14);
% xlabel('Time (seconds)','fontsize',14); ylabel('Amplitude','fontsize',14');
% axis tight

% Plot spectral magnitude
freq = freqStep*(-N/2:N/2-1);
% subplot(2,1,2);
figure() ;
plot(freq, abs(Y), '.-b'); grid on
    title('Single-Sided Amplitude Spectrum','fontsize',14)
    xlabel('Frequency (rad/sec)  (Linear) ','fontsize',14)
    ylabel('Magnitude |Y(f)|','fontsize',14);
    grid on

% Plot phase
% figure()
% plot(freq, angle(Y), '.-b'); grid on
% xlabel('Frequency)','fontsize',14); 
% ylabel('Phase (Radian)','fontsize',14);

end