clc
clear all
close all

Fs = 1000 ;                    % Sampling frequency
T = 1/Fs ;                     % Sample time
L = 1000 ;                     % Length of signal
t = (0:L-1)*T ;                % Time vector
% Sum of a 50 Hz sinusoid and a 120 Hz sinusoid
s1 = sin(2*pi*50*t) ;
s2 = 0.8*sin(2*pi*120*t) ; 
s3 = normrnd(0,1,1,L) ;
% 
% save data
% load data

signal = s2 ;
noise = s3 ;

SNR = 10 * log10(sqrt(mean(signal.^2))/sqrt(mean(noise.^2))) ;

s = signal + noise ;

figure()
plot(t,s,'linewidth',2)
hold on
plot(t,signal,'r','linewidth',2)


%%

figure()
Psd_FFT = PsdFigure(s) ;
xlabel('Frequency(Hz)')
ylabel('Power/Frequency')
grid on

level = 3 ;
wname = 'db7' ;
E = 'shannon' ;

T = wpdec(s,level,wname,E) ;
% T = besttree(T) ;

for j = 1:level
    figure()
    Psd_WP = [] ;
    for i = 0:2^j-1
        rcfs = wprcoef(T,[j i]) ;
        h = runstest(rcfs) ;
        H(j,i+1) = h ;
        subplot(2^j+1,1,i+2)
        Psd_WP(i+1,:) = PsdFigure(rcfs) ;
    end
    
    NFFT = 2^nextpow2(L); % Next power of 2 from length of y
    f = Fs/2*linspace(0,1,NFFT/2+1) ;
    
    subplot(2^j+1,1,1)
    plot(f,Psd_FFT,'k','linewidth',3)
    hold on
    plot(f,sum(Psd_WP),'linewidth',2)
end
% close all

% figure()
% plot(Psd_FFT,'k','linewidth',2)
% hold on
% plot(sum(Psd_WP),'r','linewidth',2)

%%
