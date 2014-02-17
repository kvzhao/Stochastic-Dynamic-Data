clc
% clear all
close all

freq = 0.01:0.01:100 ;

[z,p,k] = buttap(1) ;
TF1 = zpk(z,p,k) ;
[mag,phase] = bode(TF1,freq) ;
MagdB(1,:) = 20*log10(mag(:)') ;

[z,p,k] = buttap(2) ;
TF2 = zpk(z,p,k) ;
[mag,phase] = bode(TF2,freq) ;
MagdB(2,:) = 20*log10(mag(:)') ;

[z,p,k] = buttap(5) ;
TF5 = zpk(z,p,k) ;
[mag,phase] = bode(TF5,freq) ;
MagdB(3,:) = 20*log10(mag(:)') ;

figure(1)
semilogx(freq,MagdB,'linewidth',2)
legend('n=1','n=2','n=5','Location','SouthWest')
grid on
xlabel('Frequency(rad/sec)')
ylabel('Magnitude(dB)')

%%
% fs = 1 ;
data_length = 1e4 ;
% f = (1:data_length)/(2*data_length)*fs ;

%  x = wgn(data_length,1,0);
%  myfft(x) ; 
 y(:,1) = lsim(TF1,x,0:data_length-1);
 y(:,2) = lsim(TF2,x,0:length(x)-1);
 y(:,3) = lsim(TF5,x,0:length(x)-1);

 myfft(y(:,1));







% figure()  
% plot(x,'k','linewidth',2)
% hold on
% plot(y(:,1),'b','linewidth',2)
% xlabel('$t$','Interpreter','latex','fontsize',14)
% ylabel('value')
% title('1st-order Butterworth filter')
% 
% figure()
% plot(x,'k','linewidth',2)
% hold on
% plot(y(:,2),'g','linewidth',2)
% xlabel('$t$','Interpreter','latex','fontsize',14)
% ylabel('value')
% title('2nd-order Butterworth filter')
% 
% figure()
% plot(x,'k','linewidth',2)
% hold on
% plot(y(:,3),'r','linewidth',2)
% xlabel('time(sec)')
% ylabel('value')
% title('5th-order Butterworth filter')
Rxx = xcorr(x,'biased' ) ; 
Rxx1 = xcorr( y(:,1),'biased' ) ; 
Rxx2 = xcorr( y(:,2),'biased' ) ; 
Rxx3 = xcorr( y(:,3),'biased' ) ; 

Sxx = fft(Rxx) ;
Sx1 = fft(Rxx1) ;
Sx2 = fft(Rxx2) ;
Sx3 = fft(Rxx3) ;

Sxx = 10*log10(abs(Sxx(1:data_length,:)))' ;
Sx(1,:) = 10*log10(abs(Sx1(1:data_length,:)))' ;
Sx(2,:) = 10*log10(abs(Sx2(1:data_length,:)))' ;
Sx(3,:) = 10*log10(abs(Sx3(1:data_length,:)))' ;

% figure(1)
% semilogx(2*pi*f,Sxx,'k','linewidth',2)
% % figure()
% hold on
% semilogx(2*pi*f,Sx(1,:),'b','linewidth',2)
% hold on
% semilogx(freq,MagdB(3,:),'k','linewidth',2)
% axis([0.005 10 -30 10])
% xlabel('Frequency(rad/sec)')
% ylabel('Magnitude(dB)')
% title('1st-order Butterworth filter')