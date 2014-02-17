clc  ; clear all ; close all ; 
%% Gaussian White Process
% n = 1e2;  % number
% p = 0 ;        % power 
% y = wgn(1, n, p) ; 
% y2 = normrnd(0,1,n,1);

%% plotting the gaussian process
% figure() 
% plot( y,'-','linewidth',1.5) ; 
% title('Gaussian White Process','Interpreter','latex','fontsize',14);
% ylabel('Amptitude','Interpreter','latex','fontsize',14);
% xlabel('Time','Interpreter','latex','fontsize',14) ;
% grid on 
% % figure() 
% % hist(y)

%% Autocorrelation 
% figure()
% nLag = 20;
% autocorr(y,nLag)

%% Power Spectrum
% figure()
% Y = fft(y,251) ; 
% Pyy = Y.*conj(Y)/251;
% 
% f = 1000/251*(0:127);
% plot(f,Pyy(1:128)); grid on;
% title('Power spectral density','Interpreter','latex','fontsize',14)
% xlabel('Frequency (Hz)','Interpreter','latex','fontsize',14)

%% Bode Diagram
%first order low pass filter 
num = 1;
den = [2,1];
filter1 = tf(num,den) ;
figure()
bode(filter1) ; 
grid on 
%second order low pass filter 
num = .25;
den = [1,.7071,.25];
filter2 = tf(num,den) ;
figure()
bode(filter2) ;
grid on
figure()
pzmap(filter2)


