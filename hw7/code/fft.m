function myfft( x ) 

% FFT setting 
N = 512; 
fs = 8000;			
freqStep = fs/N;		

f = 10*freqStep;		
time = (0:N-1)/fs;		
y = x(1:N) ; 
Y = fft(y);			
Y = fftshift(Y);		


% Plot time data
subplot(3,1,1);
plot(time, y, '.-');
title('Sinusoidal signals');
xlabel('Time (seconds)'); ylabel('Amplitude');
axis tight

% Plot spectral magnitude
freq = freqStep*(-N/2:N/2-1);
subplot(3,1,2);
plot(freq, abs(Y), '.-b'); grid on
xlabel('Frequency)'); 
ylabel('Magnitude (Linear)');

% Plot phase
subplot(3,1,3);
plot(freq, angle(Y), '.-b'); grid on
xlabel('Frequency)'); 
ylabel('Phase (Radian)');
end