clc ; 
close all ; 
% clear all ; 


%% System 
wn = 0.5;
zeta = .7071;
num = wn.^2;
den = [ 1 , 2*zeta*wn, wn.^2] ; 
H = tf(num,den);

%% Signal Specs
N = 1e3;
w = wgn(N,1,1);
Fs = 1; 
Tstep = 1/Fs; 
t = (0:N-1)*Tstep;

%% Time Response
y = lsim(H,w,t);

%%  Spectral Density function 
% [pxx,w] = periodogram(y);
% figure()
% plot(w,pxx)
% figure()
% px = pwelch(y);
% plot(px)

%% 


