clc ; close all ; 

%% ===========  DATA GEN ================================
% % Specs
Fs = 10 ;                                  % Sampling frequency
T = 1/Fs;                                    % Sample time
L = 1e3;                                      % Data length 
t = (0:L-1)*T ;                            % Time Vector

f0 = 1 ;                                       % Frequency of sine in Hz
W = 2*pi*f0;
A = 1 ;
% Gen func
s = A*sin(W*t);
sigma = 1; mean = 0 ; 
w = normrnd(mean,sigma,1,size(t,2));
%% ===========  END OF DATA GEN =========================

% %fs = 100Hz, f0 = 1Hz, timespan=1000 secs
load 1e5SINfs100 ;    
load 1e5TIMEfs100;
load 1e5Wfs100;

%% =========== SYSTEM ===================================

%% ========== END OF SYSTEM ==% 
num = .25 ; 
den = [1 .7071 .25];
% nf = 2*pi*1;
% zeta = .1;
% 
% num = nf^2; 
% den = [1,2*zeta*nf,nf^2];

H = tf(num,den);
y = lsim(H,w+s,t);
%% ===========================
    freq = 0.01:0.01:100 ;
    [mag,phase] = bode(H,freq) ;
    MagdB(1,:) = 20*log10(mag(:)') ;

    figure() 
    semilogx( freq,MagdB(1,:) ,'linewidth',2) 
    title('Bode Plot','fontsize',14)
    xlabel('Frequency (Hz)  (Log Scale) ','fontsize',14)
    ylabel('Magnitude (dB) ','fontsize',14);
    grid on 
    
% load 1e5Yfs100;

%% ================= SIGNAL PROCESSING========================

% % FFT
    Fs = 100; %Hz
    L = length(y);
    NFFT = 2^nextpow2(L); % Next power of 2 from length of y
    Y = fft(y,NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);

    % Plot single-sided amplitude spectrum.
    figure()
%     2*abs(Y(1:NFFT/2+1) 

    plot(f,20*log10(abs(Y(1:NFFT/2+1))),'LineWidth',1.5) 
    title('Single-Sided Amplitude Spectrum','fontsize',14)
    xlabel('Frequency (Hz)  (Linear Scale) ','fontsize',14)
    ylabel('Magnitude (dB) ','fontsize',14);
    grid on
    
    figure()  
    % Bandwidth
    semilogx([0.4994 0.4994],[0,.015],'r','LineWidth',1.5); hold on ; 
    semilogx(f,20*log10(abs(Y(1:NFFT/2+1))),'LineWidth',1.5);
    legend('BandWidth','Spectrum') 
    title('Single-Sided Amplitude Spectrum','fontsize',14)
    xlabel('Frequency (Hz)  (Log Scale) ','fontsize',14)
    ylabel('Magnitude |Y(f)| (dB)','fontsize',14);
    grid on

N = ceil(length(y));
win = hamming(N);
wy = y(1:N).*win(1:N);
my_FFT(wy,Fs,N);

figure()
plot(win,'--r','linewidth',1.5); hold on;
plot(y,'g','linewidth',2); hold on ;
plot(wy,'linewidth',2) ;
title('Impact of observation interval on FFT','interpreter','latex','fontsize',14);
xlabel('$Times (sec)$','interpreter','latex','fontsize',14);ylabel('$Signal$','interpreter','latex','fontsize',14);
legend('Rectangular Window','Time-Limited Measured Signal','Signal After Windowing','interpreter','latex','fontsize',14)

%% =================  END OF SIGNAL PROCESSING=================
 
win = triang(N);
wy = y(1:N).*win(1:N);
my_FFT(wy,Fs,N);

figure()
plot(win,'--r','linewidth',1.5); hold on;
plot(y,'g','linewidth',2); hold on ;
plot(wy,'linewidth',2) ;
title('Impact of observation interval on FFT','interpreter','latex','fontsize',14);
xlabel('$Times (sec)$','interpreter','latex','fontsize',14);ylabel('$Signal$','interpreter','latex','fontsize',14);
legend('Triangular Window','Time-Limited Measured Signal','Signal After Windowing','interpreter','latex','fontsize',14)