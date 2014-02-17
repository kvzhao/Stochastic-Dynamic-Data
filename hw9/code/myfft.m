function myfft( x , N ) 
% FFT setting 
%   N = 1024; 
  fs = 1e-4;	% in Hz
  freqStep = fs/N;		

% f = 10*freqStep;		
time = (0:N-1)/fs;		

y = x(1:N) ; 
Y = fft(y);			
Y = fftshift(Y);		

% Plot time data

% subplot(2,1,1);
figure() ;
plot(time, y, '.-');
title('Signals','fontsize',14);
xlabel('Time (seconds)','fontsize',14); ylabel('Amplitude','fontsize',14');
axis tight

% Plot spectral magnitude
freq = freqStep*(-N/2:N/2-1);
% subplot(2,1,2);
figure() ;
plot(freq, abs(Y), '.-b'); grid on
xlabel('Frequency (rad/sec)','fontsize',14); 
ylabel('Magnitude (Linear)','fontsize',14);
title(' FFT ','fontsize',14) ; 

% Plot phase

figure()
plot(freq, angle(Y), '.-b'); grid on
xlabel('Frequency)','fontsize',14); 
ylabel('Phase (Radian)','fontsize',14);

end