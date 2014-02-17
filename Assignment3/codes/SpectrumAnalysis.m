clc ; close all ; 
% clear all ; 

%% Loading Signal - GWN + 1Hz and 10Hz sinusodial wave
Fs = 100;
% load t.mat ;
% load w.mat ;
% load s1.mat ;
% load s2.mat ;

load ns.mat ;
% load ns2.mat

%% Direct FFT Specetrum
% my_FFT(ns);

%% Wavelet Decomposition
s = ns(2000:4000-1);
% s = w(2000:4000-1) + s1(2000:4000-1);

%% Wavelet Packet
level =3; 
wname = 'db5';

% level = 3 ;
% wname = 'haar';

ename = 'shannon';

tree = wpdec(s,level,wname,ename);
% tree = besttree(tree);

% [thr,sorh,keepapp,crit] = ddencmp('den','wp',ns);
% figure
% plot(tree)

cfs1 = wprcoef(tree,[1,0]);
cfs2 = wprcoef(tree,[2,0]);
cfs3 = wprcoef(tree,[2,1]);
cfs4 = wprcoef(tree,[3,2]);

% cfs9 = wprcoef(tree,[3,3]);

cfs5 = wprcoef(tree,[1,1]);
cfs6 = wprcoef(tree,[2,3]);
cfs7 = wprcoef(tree,[2,2]);
cfs8 = wprcoef(tree,[3,5]);

test = [runstest(cfs1),runstest(cfs2),runstest(cfs3),runstest(cfs4);
             runstest(cfs5),runstest(cfs6),runstest(cfs7),runstest(cfs8)];

%% Decomposition
figure
% LHS
subplot(421); plot(cfs1,'g'); ylabel('$A_1$','interpreter','latex','fontsize',14); grid on ;
title('Approximations','interpreter','latex','fontsize',14);
subplot(423); plot(cfs2,'g'); ylabel('$AA_2$','interpreter','latex','fontsize',14);grid on ;
subplot(425); plot(cfs3,'g'); ylabel('$AD_2$','interpreter','latex','fontsize',14);grid on ;
subplot(427); plot(cfs4,'g'); ylabel('$ADA_3$','interpreter','latex','fontsize',14);grid on ;
% RHS
subplot(422); plot(cfs5,'mag'); ylabel('$D_1$','interpreter','latex','fontsize',14);grid on ;
title('Details','interpreter','latex','fontsize',14);
subplot(424); plot(cfs6,'mag'); ylabel('$DD_2$','interpreter','latex','fontsize',14);grid on ;
subplot(426); plot(cfs7,'mag'); ylabel('$DA_2$','interpreter','latex','fontsize',14);grid on ;
subplot(428); plot(cfs8,'mag'); ylabel('$DAD_3$','interpreter','latex','fontsize',14);grid on ;

%% PSD
figure
% % LHS
subplot(421); [f,spec1] = my_FFTv(cfs1);plot(f,spec1,'b'); ylabel('$A_1$','interpreter','latex','fontsize',14); grid on ;
title('FFT of Approximations','interpreter','latex','fontsize',14);
subplot(423); [f,spec2] = my_FFTv(cfs2);plot(f,spec2,'b'); ylabel('$AA_2$','interpreter','latex','fontsize',14);grid on ;
subplot(425); [f,spec3] = my_FFTv(cfs3);plot(f,spec3,'b'); ylabel('$AD_2$','interpreter','latex','fontsize',14);grid on ;
subplot(427); [f,spec4] = my_FFTv(cfs4);plot(f,spec4,'b'); ylabel('$ADA_3$','interpreter','latex','fontsize',14);grid on ;
% RHS
subplot(422); [f,spec5] = my_FFTv(cfs5);plot(f,spec5,'r'); ylabel('$D_1$','interpreter','latex','fontsize',14);grid on ;
title('FFT of Details','interpreter','latex','fontsize',14);
subplot(424); [f,spec6] = my_FFTv(cfs6);plot(f,spec6,'r'); ylabel('$DD_2$','interpreter','latex','fontsize',14);grid on ;
subplot(426); [f,spec7] = my_FFTv(cfs7);plot(f,spec7,'r'); ylabel('$DA_2$','interpreter','latex','fontsize',14);grid on ;
subplot(428); [f,spec8] = my_FFTv(cfs8);plot(f,spec8,'r'); ylabel('$DAD_3$','interpreter','latex','fontsize',14);grid on ;

figure
% plot(f,spec1,f,spec2,f,spec3,f,spec4,f,spec5,f,spec6,f,spec7,f,spec8,'linewidth',1.3);

plot(f,spec1,'r','linewidth',1.3); hold on ;
plot(f,spec2,'b','linewidth',1.3);hold on ;
plot(f,spec3,'g','linewidth',1.3);hold on ;
plot(f,spec4,'k','linewidth',1.3);hold on ;

plot(f,spec5,'y','linewidth',1.3); hold on ;
plot(f,spec6,'m','linewidth',1.3);hold on ;
plot(f,spec7,'c','linewidth',1.3);hold on ;
plot(f,spec8,'--g','linewidth',1.3);hold on ;

title('FFT of Wavelet Decomposed Signal','interpreter','latex','fontsize',14);
    xlabel('Frequency (Hz)  (Linear Scale) ','interpreter','latex','fontsize',14)
    ylabel('Amplitude $|Y(f)|$','interpreter','latex','fontsize',14);
    grid on; axis tight
legend('Approximation A_1','Approximation AA_2','Approximation AD_2','Approximation ADA_3'...
               ,'Detail D_1','Detail DD_2','Detail DA_2','Detail DAD3');


% plot(cfs1(1:200),'r'); hold on ; plot( cfs2(1:200)); legend('A_1','AA_2') ; 
% title('Comparison of Approximation','interpreter','latex','fontsize',14);

% figure
% my_FFT(cfs1);
% title('FFT of Approximation $A_1$','interpreter','latex','fontsize',14);
% ylabel('Magtitude/frequency ($y^2/Hz$)','interpreter','latex','fontsize',14);
% xlabel('Frequency $(Hz)$ in log scale','interpreter','latex','fontsize',14);
% grid on ; 
% figure
% my_FFT(cfs2);
% title('FFT of Approximation $AA_2$','interpreter','latex','fontsize',14);
% ylabel('Magtitude/frequency ($y^2/Hz$)','interpreter','latex','fontsize',14);
% xlabel('Frequency $(Hz)$ in log scale','interpreter','latex','fontsize',14);
% grid on ; 
% figure
% my_FFT(cfs3);
% title('FFT of Approximation $DA_2$','interpreter','latex','fontsize',14);
% ylabel('Magtitude/frequency ($y^2/Hz$)','interpreter','latex','fontsize',14);
% xlabel('Frequency $(Hz)$ in log scale','interpreter','latex','fontsize',14);
% grid on ; 
% figure
% my_FFT(cfs5);
% title('FFT of Approximation $D_1$','interpreter','latex','fontsize',14);
% ylabel('Magtitude/frequency ($y^2/Hz$)','interpreter','latex','fontsize',14);
% xlabel('Frequency $(Hz)$ in log scale','interpreter','latex','fontsize',14);
% grid on ; 
% figure
% my_FFT(cfs6);
% title('FFT of Approximation $DA_2$','interpreter','latex','fontsize',14);
% ylabel('Magtitude/frequency ($y^2/Hz$)','interpreter','latex','fontsize',14);
% xlabel('Frequency $(Hz)$ in log scale','interpreter','latex','fontsize',14);
% grid on ; 
% figure
% my_FFT(cfs8);
% title('FFT of Approximation $ADD_3$','interpreter','latex','fontsize',14);
% ylabel('Magtitude/frequency ($y^2/Hz$)','interpreter','latex','fontsize',14);
% xlabel('Frequency $(Hz)$ in log scale','interpreter','latex','fontsize',14);
% grid on ; 


% figure
% plot(cfs1) ;hold on ; plot(cfs2,'r');
% ffs1 = my_FFT(cfs3);
% figure
% [f,spec] = my_PSD(cfs1);
% subplot(321)
% semilogx(f,spec);
% [f,spec] = my_PSD(cfs3);
% subplot(323)
% semilogx(f,spec);
% [f,spec] = my_PSD(cfs4);
% subplot(325)
% semilogx(f,spec);
% [f,spec] = my_PSD(cfs2);
% subplot(322)
% semilogx(f,spec);
% [f,spec] = my_PSD(cfs5);
% subplot(324)
% semilogx(f,spec);
% [f,spec] = my_PSD(cfs6);
% subplot(326)
% semilogx(f,spec);

% [f,spec] = my_FFTv(cfs1);
% subplot(321)
% semilogx(f,spec);
% [f,spec] = my_FFTv(cfs3);
% subplot(323)
% semilogx(f,spec);
% [f,spec] = my_FFTv(cfs4);
% subplot(325)
% semilogx(f,spec);
% [f,spec] = my_FFTv(cfs2);
% subplot(322)
% semilogx(f,spec);
% [f,spec] = my_FFTv(cfs5);
% subplot(324)
% semilogx(f,spec);
% [f,spec] = my_FFTv(cfs6);
% subplot(326)
% semilogx(f,spec);

% [f,spec] = my_FFTv(cfs1);
% subplot(321)
% plot(f,spec);
% [f,spec] = my_FFTv(cfs3);
% subplot(323)
% plot(f,spec);
% [f,spec] = my_FFTv(cfs4);
% subplot(325)
% plot(f,spec);
% [f,spec] = my_FFTv(cfs2);
% subplot(322)
% plot(f,spec);
% [f,spec] = my_FFTv(cfs5);
% subplot(324)
% plot(f,spec);
% [f,spec] = my_FFTv(cfs6);
% subplot(326)
% plot(f,spec);
