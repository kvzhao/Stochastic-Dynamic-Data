clc ; close all ; clear all; 

fs = 100; % Sampling Rate 
T = 1/fs ; % Time Step
L = 2^9; % Time Length
t = (0:L-1)*T; % time space
A = 1 ; 
f0 =1 ; % Hz  sine freq

s = A*sin(2*pi*f0*t);
% w = normrnd(0,1,1,L);

% my_FFT(s,fs);

% N = length(s);
% Hwin = hamming(N);
% ws = s(:).*Hwin(:);
% figure();
% plot(t,ws);
% my_FFT(ws,fs);
 
% Bwin = blackman(N);
% ws = s(:).*Bwin(:);
% figure();
% plot(t,ws);
% my_FFT(ws,fs);

% num = .25 ; 
% den = [1 .7071 .25];

% nf = 2*pi*10;
% zeta = 2;
% 
% num = nf^2; 
% den = [1,2*zeta*nf,nf^2];
% 
% H = tf(num,den);
% bode(H)

% y = lsim(H,s,t);
N = ceil(L/4);
% N = 2^nextpow2(L);
my_FFT(s,fs,N);
figure()
plot(t(1:N),s(1:N),'linewidth',2);
ss = s(1:N);
title('Testing Sine Wave','interpreter','latex','fontsize',14);
xlabel('$Times (sec)$','interpreter','latex','fontsize',14);ylabel('$Signal$','interpreter','latex','fontsize',14);


Hwin = hamming(N);
ws = ss(:).*Hwin(:);

figure()
plot(Hwin,'--r','linewidth',1.5); hold on;
plot(ss,'g','linewidth',2); hold on ;
plot(ws,'linewidth',2) ;

title('Impact of observation interval on FFT','interpreter','latex','fontsize',14);
xlabel('$Times (sec)$','interpreter','latex','fontsize',14);ylabel('$Signal$','interpreter','latex','fontsize',14);
legend('Hamming Window','Time-Limited Measured Signal','Signal After Windowing','interpreter','latex','fontsize',14)

my_FFT(ws,fs,N);


Rwin = triang(N);
rs = ss(:).*Rwin(:);

figure()
plot(Rwin,'--r','linewidth',1.5); hold on;
plot(ss,'g','linewidth',2); hold on ;
plot(rs,'linewidth',2) ;

title('Impact of observation interval on FFT','interpreter','latex','fontsize',14);
xlabel('$Times (sec)$','interpreter','latex','fontsize',14);ylabel('$Signal$','interpreter','latex','fontsize',14);
legend('Rectangular Window','Time-Limited Measured Signal','Signal After Windowing','interpreter','latex','fontsize',14)

my_FFT(rs,fs,N);


