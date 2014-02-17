clc
clear all
close all
warning off 

%% Data Source ================================================================
N = 1000 ;
avg  = 0 ; dev = 1 ; 
x = normrnd(avg,dev,N,1) ;
Fs = 1 ;
fc = .5  ;

t = 0:(N-1) ;
f = [0:N/2-1]/N ;

Hwin = hamming(N);
%% System ================================================================

wn = 0.5;
zeta = .7071;
num = wn.^2;
den = [ 1 , 2*zeta*wn, wn.^2] ; 
H = tf(num,den);
 y = lsim(H,x,t);
% load y.mat 

%% Matlab function  code ================================================================
% % 
% % figure()
% % pwelch(y,[],[],[],Fs) ;
% % [Pxx,w] = pwelch(y,[],[],999,Fs) ;
% % set(findobj('Type','line'),'linewidth',3,'Color','k')
% % % title('')
% figure()
% plot(w,Pxx,'k','linewidth',3)
freq = .3 ; % in Hz
A = 10; 
s = A*sin( 2*pi*freq*t);
ys = y + s' ; 
% figure()
% plot(ys)
% load ys.mat

%% Narrow Band-passed Filterd Method ================================================================
% B = 1e-3;
% Gx1 = nan * zeros(N/2,1);
% for i = 1:N/2
% f0 = f(i) ;
% % % % % num = [1 0] ;
% num = [0.01 0] ;
% den = [1 2*pi*B (pi*B)^2+(2*pi*f0)^2] ;
% NPF = tf(num,den) ;
% fil = lsim(NPF,y,t);
% Gx1(i) = mean(abs(fil).^2)/B ;
% end
% G1dB = 10*log10(Gx1) ;


%%  Indirect Method - transform from autocorrelation function================================================================

% timeSpan = 999  ;
% R  = Autocorr(y,timeSpan) ;
% tau = 0:(timeSpan) ;
% 
% theta = pi*tau/fc ;
% G2 = nan * zeros(1,length(f)) ;
% for i = 1:length(f)
%     cos_theta = cos(theta*f(i)) ;
%     G2(i) = 2*(- R(1) + 2*sum(R.*cos_theta) - R(end)*cos_theta(end)) ;
% end
% G2 = abs(G2);
% G2dB = 10*log10(G2(1:N/2)) ;
% plot(G2dB,'r','linewidth',1);
% title('Power Spectral Density - Blackman-Turkey Method','interpreter','latex','fontsize',14);
% xlabel('Frequency (mHz in linear)','interpreter','latex','fontsize',14);ylabel('PSD (dB/mHz)','interpreter','latex','fontsize',14);
% grid on ; axis tight

%% Direct Method 

% % Hwin = hamming(N);
% % ws = y(:).*Hwin(:);
% % yn = fft(ws) ;

% yn = fft(y);
% G3 = 2/N * abs(yn).^2 ;
% G3dB = 10*log10(G3(1:N/2)) ;

% % legend('Welch','Narrow-band','Blackman-Turkey','DFT')
% 


    
%% Load Data and plot ================================================================

load G1dB.mat ; 
% load G2dB.mat;
load G3dB.mat;

% load sG1dB.mat ; 
% load sG2dB.mat;
% load sG3dB.mat;

% figure(); plot(G1dB); hold on ; plot(G2dB,'r');hold on ; plot(G3dB,'g')


% figure()
% plot(G1dB,'linewidth',1.3);
% title('Power Spectral Density - Narrow Bandwith Filter Method','interpreter','latex','fontsize',14);
% xlabel('Frequency (mHz in linear)','interpreter','latex','fontsize',14);ylabel('PSD (dB/mHz)','interpreter','latex','fontsize',14);
% grid on ;
% % legend('Hamming Window','Time-Limited Measured Signal','Signal After Windowing','interpreter','latex','fontsize',14)
% figure()
% plot(G2dB,'r','linewidth',1.3);
% title('Power Spectral Density - Blackman-Turkey Method','interpreter','latex','fontsize',14);
% xlabel('Frequency (mHz in linear)','interpreter','latex','fontsize',14);ylabel('PSD (dB/mHz)','interpreter','latex','fontsize',14);
% grid on ;
% figure()
% plot(G3dB,'g','linewidth',1.3);
% title('Power Spectral Density - DFT Method','interpreter','latex','fontsize',14);
% xlabel('Frequency (mHz in linear)','interpreter','latex','fontsize',14);ylabel('PSD (dB/mHz)','interpreter','latex','fontsize',14);
% grid on ;
% % 
% figure(); plot(G1dB,'linewidth',1.3); hold on ; plot(G2dB,'r','linewidth',1.3);hold on ; plot(G3dB,'g','linewidth',1.3)
% title('Power Spectral Density','interpreter','latex','fontsize',14);
% xlabel('Frequency (mHz in linear)','interpreter','latex','fontsize',14);ylabel('PSD (dB/mHz)','interpreter','latex','fontsize',14);
% legend('Narrow Bandwith Filter Method','Blackman-Turkey Method','DFT Method');
% grid on ;

% % % % figure(); plot(G1dB,'linewidth',1.3); hold on ; plot(G2dB,'--r','linewidth',1.3);hold on ; plot(G3dB,'--g','linewidth',1.3)
% % % % px = pwelch(y,512,256,length(ys),Fs,'onesided');
% % % % pxdB = 10*log10(px);
% % % % hold on ; plot(pxdB,'k','linewidth',2); grid on ; 
% % % % title('Power Spectral Density','interpreter','latex','fontsize',14);
% % % % xlabel('Frequency (mHz in linear)','interpreter','latex','fontsize',14);ylabel('PSD (dB/mHz)','interpreter','latex','fontsize',14);
% % % % legend('Narrow Bandwith Filter Method','Blackman-Turkey Method','DFT Method','Welch-Bartlett Method');
% % % % grid on ; axis tight



% % FFT
% 
% % y = ys(:) .* hamming(length(ys));
% 
%     L = length(y);
%     NFFT = 2^nextpow2(L); % Next power of 2 from length of y
%     Y = fft(y,NFFT)/L;
%     Mag = abs(Y(1:NFFT/2+1)); 
%     figure()
%     plot(20*log10(Mag),'LineWidth',1.5) 
%     title('Single-Sided Amplitude Spectrum (FFT)','interpreter','latex','fontsize',14)
%     xlabel('Frequency (mHz)  (Linear Scale) ','interpreter','latex','fontsize',14)
%     ylabel('Magnitude (dB) ','interpreter','latex','fontsize',14);
%     grid on ; axis tight
    
  %% MATLAB Function ================================================================

% figure()
px = pwelch(y,512,128,length(y),Fs,'onesided');
pxdB = 10*log10(px);
plot(pxdB,'--m','linewidth',1.5); grid on ; 
title('Power Spectral Density - Welch method','interpreter','latex','fontsize',14);
xlabel('Frequency (mHz in linear)','interpreter','latex','fontsize',14);ylabel('PSD (dB/mHz)','interpreter','latex','fontsize',14);
grid on ; axis tight
% 
% % Compare BT and Welch
% 
% figure()
% plot(pxdB,'linewidth',1.5); hold on ; plot(G2dB,'r','linewidth',1.5);
% title('Power Spectral Density','interpreter','latex','fontsize',14);
% xlabel('Frequency (mHz in linear)','interpreter','latex','fontsize',14);ylabel('PSD (dB/mHz)','interpreter','latex','fontsize',14);
% legend('Welch-Bartlett method','Blackman-Turkey Method');
% grid on ;axis tight

%% Periodogram

figure()
ppx = periodogram(ys,Hwin,length(ys),Fs,'onesided');
ppxdB = 10*log10(ppx);
plot(ppxdB,'--m','linewidth',1.5); grid on ; 
title('Power Spectral Density - Periodogram','interpreter','latex','fontsize',14);
xlabel('Frequency (mHz in linear)','interpreter','latex','fontsize',14);ylabel('PSD (dB/mHz)','interpreter','latex','fontsize',14);
grid on ; axis tight
% Compare BT and Welch

% figure()
% plot(pxdB,'linewidth',1.5); hold on ; plot(G2dB,'r','linewidth',1.5);
% title('Power Spectral Density','interpreter','latex','fontsize',14);
% xlabel('Frequency (mHz in linear)','interpreter','latex','fontsize',14);ylabel('PSD (dB/mHz)','interpreter','latex','fontsize',14);
% legend('Welch-Bartlett method','Blackman-Turkey Method');
% grid on ;axis tight


% plot(Pxx,'k','linewidth',3)
% hold on
% % plot(G1(1:n/2),'b','linewidth',1)
% plot(G2(1:n/2),'r','linewidth',1)
% % plot(G3(1:n/2),'g','linewidth',1)
% xlabel('frequency(mHz)')
% ylabel('G(f)')
% % legend('Welch','Narrow-band','Blackman-Turkey','DFT')
% legend('Welch','Blackman-Turkey')
% % legend('Welch','DFT')
