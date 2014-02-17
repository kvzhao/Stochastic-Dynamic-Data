function myfft( x ) 

% FFT setting 
  N = 1024; 
  fs = 5;		
freqStep = fs/N;		

% f = 10*freqStep;		
% time = (0:N-1)/fs;		

y = x(1:N) ; 
Y = fft(y);			
Y = fftshift(Y);		

figure() ;
% Plot time data

% subplot(2,1,1);
% plot(time, y, '.-');
% title('Signals');
% xlabel('Time (seconds)'); ylabel('Amplitude');
% axis tight

% Plot spectral magnitude
freq = freqStep*(-N/2:N/2-1);
% subplot(2,1,2);
plot(freq, abs(Y), '.-b'); grid on
xlabel('Frequency','fontsize',14); 
ylabel('Magnitude (Linear)','fontsize',14);
title(' FFT ','fontsize',14) ; 

% Plot phase

% subplot(3,1,3);
% plot(freq, angle(Y), '.-b'); grid on
% xlabel('Frequency)'); 
% ylabel('Phase (Radian)');

end