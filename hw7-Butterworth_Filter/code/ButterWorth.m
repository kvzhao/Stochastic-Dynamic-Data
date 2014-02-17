clc; clear all; close all ; 

fs=100;                    % Sampling rate
filterOrder=1;		     % Order of filter
cutOffFreq=1;       % Cutoff frequency
N = 512 ; 
[b, a]=butter(filterOrder, cutOffFreq/(fs/2), 'low');

[h, w]=freqz(b, a);
figure() 
plot(w/pi*fs/2, abs(h), '.-'); 
title('Magnitude frequency response');
grid on

% t = 0:.1:100; 
% x = sin(2*pi*t) ; 
n = 1e4; 
std = 1; avg = 0 ; 
x = normrnd( avg , std, 1 , n ) ; 

figure() 
myfft( x ,fs ,N ) ; 
y = filter(a,b,x) ; 
figure() 
myfft( y ,fs ,N  ) ; 
[z,p,k] =butter(filterOrder, cutOffFreq/(fs/2), 'low');
sys = zpk(z,p,k) ; 

% figure() 
% subplot(2,1,1);
% plot(time, x);
% subplot(2,1,2);
% plot(time, y);
