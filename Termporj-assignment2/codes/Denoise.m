clc ;close all ;
clear all ;
load data.mat
s = s1 ; 

plot(s); 
title('The Original Signal','interpreter','latex','fontsize',14);
xlabel('Time Span (sec)','interpreter','latex','fontsize',14);ylabel('Amplitute','interpreter','latex','fontsize',14);
grid on ; axis tight

% t = 0:0.001:10;      % 10 seconds @ 1kHz sample rate
% fo = 10; f1 = 400;   % Start at 10Hz, go up to 400Hz
% y = chirp(t,fo,10,f1,'logarithmic');
% % spectrogram(y,256,200,256,1000,'yaxis')

%% Wavelet Packet
level =5; 
wname = 'db5';

% level = 3 ;
% wname = 'haar';

ename = 'shannon';
tree = wpdec(s1,level,wname,ename);
tree = besttree(tree);
[thr,sorh,keepapp,crit] = ddencmp('den','wp',s);

% recs = wprec(tree);
% figure
% plot(wpt)
% E = wentropy(s,ename,0);

%% Denosing
                        % % % % % SORH : soft or hard
                        % % % % % CRIT :  Entropy criteria
                        % % % % % PAR :  Threshold parameter
                        
% thr = thselect(s,'rigrsure');
% det = [wpcoef(tree,2),wpcoef(tree,3),wpcoef(tree,4)];

% sigma = median(abs(det(:)))/.6745;
alpha = 2;
% thr = wpbmpen(tree,sigma,alpha);
% thr = wpthcoef(tree,1,'s',

keepapp = 1; 
crit = 'shannon';
% crit = 'threshold';
% crit = 'sure';
% crit = 'log energy';

sorh = 's';

[ds,wpt,perf0,perfl2] = wpdencmp(s,sorh,level,wname,crit,thr,keepapp);
figure;
plot(ds,'m','linewidth',2);
title('The Denoised Signal','interpreter','latex','fontsize',14);
xlabel('Time Span (sec)','interpreter','latex','fontsize',14);ylabel('Amplitute','interpreter','latex','fontsize',14);
grid on ; 

figure
plot(s) ; hold on ; plot(ds,'r','linewidth',2);
title('Comparison of Original and Denoised Signal','interpreter','latex','fontsize',14);
xlabel('Time Span (sec)','interpreter','latex','fontsize',14);ylabel('Amplitute','interpreter','latex','fontsize',14);
legend('Heavy Sine with Noise','Denoised Signal')
grid on ; 

my_FFT(ds);

w = s - ds ; 
figure
plot(w);
title('Extracted Noise','interpreter','latex','fontsize',14);
xlabel('Time Span (sec)','interpreter','latex','fontsize',14);ylabel('Amplitute','interpreter','latex','fontsize',14);
grid on ; 
pdf = ksdensity(w); 
figure
plot(pdf,'r','linewidth',2);
normpdf = normrnd(0,1,1e5,1);
hold on ; plot( ksdensity( normpdf ) ,'--k','linewidth',2) ;
grid on 

title('Probability Density function of Gaussian Noise','interpreter','latex','fontsize',14);
xlabel('$x$','interpreter','latex','fontsize',14);ylabel('$p(x)$','interpreter','latex','fontsize',14);
legend('PDF of Extracted Noise','PDF of Original Noise')
grid on ; axis tight

disp('mean,std,A');
mean( w ) 
std(w)
max(ds)


t = 0:999;
ss = 10*sin(2*pi*.0023*(t));
% ll = 1e-2*t;
figure
plot(ss,'linewidth',2); hold on ; plot(ds,'g','linewidth',2)
title('Denoised Signal and Uncontaminated','interpreter','latex','fontsize',14);
xlabel('Time Span (sec)','interpreter','latex','fontsize',14);ylabel('Amplitute','interpreter','latex','fontsize',14);
legend('Uncontaminated Signal','Denoised Signal')
grid on 
% plot(wpt)
% plot(sd);