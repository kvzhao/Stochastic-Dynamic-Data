clc
clear all
close all

B = 0.5 * 0.01 / (2*pi) ;
f0 = 0.5 / (2*pi) ;

num = [1 0] ;
den = [1 2*pi*B (pi*B)^2+(2*pi*f0)^2] ;
%den = [1 0.1 0.25];

freq = 0.01:0.01:10 ;
TF = tf(num,den) ;


[mag,phase] = bode(TF,freq) ;
MagdB = 20*log10(mag(:)) ;

fs = 1 ;
data_length = 1e4 ;
f = (1:data_length)/(2*data_length)*fs ;

x = wgn(data_length,1,10,1);
y = lsim(TF,x,0:data_length-1);

std_y = std(y);

w = -pi+pi/data_length:pi/data_length:pi-pi/data_length;
Ry = xcorr( y,'biased' ) ;
Sy = fft(Ry) ;

% my_FFT(Ry,10);

tau = -data_length+1:data_length-1;

figure()
plot(tau,Ry)
xlabel('$\tau$','Interpreter','latex','fontsize',14)
ylabel('$R_\mathrm x$','Interpreter','latex','fontsize',14)

figure()
plot(w,abs(fftshift(Sy)),'b-')

% Sy = 10*log10(abs(Sy(1:data_length,:)))' ;

figure()
semilogx(freq,MagdB,'linewidth',2)
grid on
xlabel('frequency(rad/s)')
ylabel('amplitude(dB)')

%%
t = 1:data_length ;
R = raylrnd(std_y,1,data_length) ;
theta = pi*rand(1,data_length) - pi/2;

z = R .* cos(0.5*t + theta);

Rz = xcorr( z,'biased' ) ;
Sz = fft(Rz) ;

figure()
hold on
plot(tau,Rz,'r')

figure()
hold on
plot(w,abs(fftshift(Sz)),'r+')
xlabel('frequency(rad/s)')
ylabel('$S_\mathrm x$','Interpreter','latex','fontsize',14)


