clc; close all; 
%% DATA from simulink
% sim('noisefilter') ;
%% Time Response
step = .1;  
timeStart = 1; 
timeEnd   = 100;
t = step*[timeStart:timeEnd]'; 
% figure() 
% plot(t,firstOrder(timeStart:timeEnd),'linewidth',2) ; 
% hold on 
% plot(t,secondOrder(timeStart:timeEnd),'r','linewidth',2);
% hold on 
% % plot(t,Gaussianwhiteprocess(timeStart:timeEnd),'k--','linewidth',1.5) ; 
% grid on ; 
% legend('1st Order filter','2nd Order filter','Gaussian white process','Interpreter','latex');
% title('$y-t$','Interpreter','latex','fontsize',12); 
% xlabel('$t$','Interpreter','latex','fontsize',12); 
% ylabel('$y(t)$','Interpreter','latex','fontsize',12);

% plot(t(1:100),Gaussianwhiteprocess(1:100),'k--','linewidth',1) ; 
% for i=2:1:100
%     hold on 
%     avg = mean( Gaussianwhiteprocess(1:i) ) ; 
%     plot( t(i) ,avg , 'or','linewidth',1) ;
% end
% title('$White\ Signal\ Non-stationary\ Phenomenon$','Interpreter','latex','fontsize',12); 
% xlabel('$t$','Interpreter','latex','fontsize',12); 
% ylabel('$w(t)$','Interpreter','latex','fontsize',12); 

%% Ensemble 
MCS = 1e3 ;

TF1out = nan * ones(100,MCS) ;
TF2out = nan * ones(100,MCS) ;

for i = 1:MCS
    sim('noisefilter') ;
    TF1out(:,i) = firstOrder(timeStart:timeEnd) ; 
    TF2out(:,i) = secondOrder(timeStart:timeEnd) ; 
end

mu_1 = mean(TF1out') ;
sigma_1 = std(TF1out') ;

mu_2 = mean(TF2out') ;
sigma_2 = std(TF2out') ;


figure()
plot(t,mu_1,'b','linewidth',2)
hold on
plot(t,mu_2,'r','linewidth',2)
grid on
xlabel('$\t$','Interpreter','latex','fontsize',14)
ylabel('$\mu_y$','Interpreter','latex','fontsize',14)
title('$\mu_y-t$','Interpreter','latex','fontsize',14)
legend('1st Order filter','2nd Order filter','Interpreter','latex');

figure()
plot(t,sigma_1,'b','linewidth',2)
hold on
plot(t,sigma_2,'r','linewidth',2)
grid on
xlabel('$\t$','Interpreter','latex','fontsize',14)
ylabel('$\sigma_y$','Interpreter','latex','fontsize',14)
title('$\sigma_y-t$','Interpreter','latex','fontsize',14)
legend('1st Order filter','2nd Order filter','Interpreter','latex');

%% Histogram
% figure()
% hist(Gaussianwhiteprocess,60)
% % axis( [-5,5,0,600]);
% title('Histogram of white process','Interpreter','latex','fontsize',12);
% 
% figure()
% hist(firstOrder,60);
% % axis( [-5,5,0,600]);
% title('Histogram of 1st order filtered signal','Interpreter','latex','fontsize',12);
% 
% figure()
% hist(secondOrder,60)
% % axis([-5,5,0,600]);
% title('Histogram of 2nd order filtered signal','Interpreter','latex','fontsize',12);

%% Spectrum
% fft setting
% figure()
% N = 512 ; 
% fs = 2000;
% freqstep = fs/N ; 
% time = (0:N-1)/fs; 
% freq = freqstep* (-N/2 : N/2-1) ; 
% 
% Noise
% y = Gaussianwhiteprocess(1:length(time) ); 
% 
% subplot 211
% plot( time,y ,'.-k'); grid on ;
% title('Time Series of Gaussian White Process','Interpreter','latex','fontsize',12) ; 
% xlabel('Time','Interpreter','latex','fontsize',12);
% Y = fft( y , N) ; 
% Y = fftshift( Y ) ; 
% subplot 212
% plot( freq , abs(Y),'.-k' ) ;  grid on ;
% title('Power spectral density','Interpreter','latex','fontsize',12)
% xlabel('Frequency (Hz) in linear','Interpreter','latex','fontsize',12)
% ylabel('Magtitude','Interpreter','latex','fontsize',12)
% 2nd
% figure()
% y = secondOrder(1:length(time) ); 
% 
% subplot 413
% plot( time,y ,'.-r'); grid on ;
% title('Time Series of 2nd order filtered Signal','Interpreter','latex','fontsize',12) ; 
% xlabel('Time','Interpreter','latex','fontsize',12);
% Y = fft( y , N) ; 
% Y = fftshift( Y ) ; 
% subplot 414
% plot( freq , abs(Y),'.-r' ) ;  grid on ;
% title('Power spectral density','Interpreter','latex','fontsize',12)
% xlabel('Frequency (Hz) in linear','Interpreter','latex','fontsize',12)
% ylabel('Magtitude','Interpreter','latex','fontsize',12)
% 
% 1st
% figure()
% y = firstOrder(1:length(time) ); 
% 
% subplot 411
% plot( time,y ,'.-'); grid on ;
% title('Time Series of 1st order filtered Signal','Interpreter','latex','fontsize',12) ; 
% xlabel('Time','Interpreter','latex','fontsize',12);
% Y = fft( y , N) ; 
% Y = fftshift( Y ) ; 
% subplot 412
% plot( freq , abs(Y),'.-' ) ;  grid on ;
% title('Power spectral density','Interpreter','latex','fontsize',12)
% xlabel('Frequency (Hz) in linear','Interpreter','latex','fontsize',12)
% ylabel('Magtitude','Interpreter','latex','fontsize',12)

%% Autocorrelation
% figure()
% autocorr(Gaussianwhiteprocess)
% 
% figure()
% nlag = 300;
% autocorr(firstOrder,nlag)
% 
% figure()
% autocorr(secondOrder,nlag)