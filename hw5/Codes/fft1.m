% ���d�Үi�ܤ@��²�楿���i���ť߸��ഫ�A�H�����W�Ш����
% �������i���W�v�ꥩ�O freqStep ����ƭ��A�ҥH�����W�����ӥu����ӫD�s�I

N = 256;			% �I��
fs = 8000;			% �����W�v
freqStep = fs/N;		% �W�쪺�W�v���ѪR��
f = 10*freqStep;		% �����i���W�v�A��O freqStep ����ƭ�
time = (0:N-1)/fs;		% �ɰ쪺�ɶ����
y = cos(2*pi*f*time);		% Signal to analyze
Y = fft(y);			% Spectrum
Y = fftshift(Y);		% �N�W�v�b���s�I�m��

% Plot time data
subplot(3,1,1);
plot(time, y, '.-');
title('Sinusoidal signals');
xlabel('Time (seconds)'); ylabel('Amplitude');
axis tight

% Plot spectral magnitude
freq = freqStep*(-N/2:N/2-1);	% �W�쪺�W�v���
subplot(3,1,2);
plot(freq, abs(Y), '.-b'); grid on
xlabel('Frequency)'); 
ylabel('Magnitude (Linear)');

% Plot phase
subplot(3,1,3);
plot(freq, angle(Y), '.-b'); grid on
xlabel('Frequency)'); 
ylabel('Phase (Radian)');