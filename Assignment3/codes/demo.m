close all; clear all;



fs = 1000;
t = 0:1/fs:2; 
% create chirp signal        
y = sin(256*pi*t.^2);

figure
spectrogram(y,256,250,256,1E3,'yaxis') ;

% Plot the analyzed signal
subplot(2,1,1);
plot(t,y); 
axis tight
title('Analyzed Signal');

% Wavelet packet spectrum
level = 6;
wpt = wpdec(y,level,'sym8');
subplot(2,1,2);
[S,T,F] = wpspectrum(wpt,fs,'plot');


%% == ============================================ == 
fs = 500;
t = 0:1/fs:4;
y = sin(32*pi*t).*(t<2) + sin(128*pi*t).*(t>=2);
y2 = sin(32*pi*t).*(t>2) + sin(128*pi*t).*(t<=2);
subplot(2,1,1);
plot(t,y,'m'); 
axis tight
title('Analyzed Signal - Frequency Lifting');
subplot(2,1,2);
plot(t,y2,'m'); 

axis tight
title('Analyzed Signal - Frequency Dropping ');
% Wavelet packet spectrum

level = 6;
wpt = wpdec(y,level,'sym6');

figure
subplot(2,1,1);
[S,T,F] = wpspectrum(wpt,fs,'plot');
subplot(2,1,2);
wpt = wpdec(y2,level,'sym6');
[S,T,F] = wpspectrum(wpt,fs,'plot');
my_FFT(y);


