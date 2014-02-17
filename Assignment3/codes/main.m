clc ; 
% clear all ;
close all;

%% Signal Specs
N = 1e5;
Fs = 100; 
Tstep = 1/Fs; 
t = (0:N-1)*Tstep;

% Gaussian White
W = 1;
w = W*wgn(1,N,9);
%  Sine Wave
f1 = 1 ;   % in Hz
f2 = 10;
A1 = 12; 
A2 = 5;
s1 = A1*sin(2*pi*f1*t);
s2 = A2*sin(2*pi*f2*t);
s = s1+s2;
ns =  w + s1 + s2;

plot(ns(1:1000))
figure()
subplot(211)
plot(s1(1:200))
xlabel('Low Frequency 1 Hz','interpreter','latex','fontsize',14);ylabel('Amplitute = 12 ','interpreter','latex','fontsize',14);
title('Two Sinusoidal Compoenets','interpreter','latex','fontsize',14);
subplot(212)
plot(s2(1:200))
xlabel('High Frequency 10 Hz','interpreter','latex','fontsize',14);ylabel('Amplitute = 5 ','interpreter','latex','fontsize',14);

figure;
plot(ns(1:500),'m','linewidth',2);
title('The Contaminated Signal','interpreter','latex','fontsize',14);
xlabel('Time Span (sec)','interpreter','latex','fontsize',14);ylabel('Amplitute','interpreter','latex','fontsize',14);
grid on ; 