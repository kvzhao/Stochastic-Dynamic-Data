N = 64; % signal length (power of 2)
T = 1; % sampling period (and rate) is set to 1
A = 1; % sinusoid amplitude
phi = 0; % phase of zero
f = 0.25; % frequency (under Nyquist limit)
nT = [0:N-1]*T; % discrete time axis
x = cos(2*pi*f*nT + phi); % sinusoid
X = fft(x);

% Plot time data:
figure(1);
subplot(3,1,1);
plot(n,x,'*k');
ni = [0:.1:N-1]; % Interpolated time axis
hold on;
plot(ni,A*cos(2*pi*ni*f*T+phi),'-k'); grid off;
title('Sinusoid at 1/4 the Sampling Rate');
xlabel('Time (samples)');
ylabel('Amplitude');
text(-8,1,'a)');
hold off;

% Plot spectral magnitude:
magX = abs(X);
fn = [0:1/N:1-1/N]; % Normalized frequency axis
subplot(3,1,2);
stem(fn,magX,'ok'); grid on;
xlabel('Normalized Frequency (cycles per sample))');
ylabel('Magnitude (Linear)');
text(-.11,40,'b)');
% Same thing on a dB scale:
spec = 20*log10(magX); % Spectral magnitude in dB
spec = spec - max(spec); % Normalize to 0 db max
subplot(3,1,3);
plot(fn,spec,'--ok'); grid on;
axis([0 1 -350 50]);
xlabel('Normalized Frequency (cycles per sample))');
ylabel('Magnitude (dB)');
text(-.11,50,'c)');

