clc
clear all
close all

TF = tf(0.25,[1 0.7071 0.25]) ;

T = 1e3 ;

t = 0:T-1 ;
x = normrnd(0,1,length(t),1) ;
y = lsim(TF,x,t) ;

% auto correlation
nLags = 20 ;

    [ACF,Lags] = xcorr(y,nLags,'unbiased'); 
    index = find(Lags>=0) ;

    figure(1)
    lineHandles  =  stem(Lags(index) , ACF(index) , 'filled' , 'r-o');
    set   (lineHandles(1) , 'MarkerSize' , 4)
grid  ('on')
xlabel('Lag')
ylabel('Sample Autocorrelation')
title ('Sample Autocorrelation Function (ACF)')

[ACFb,ACFub, Lags] = dou_autocorr(y,nLags) ;

figure(1)
hold on
plot(Lags,ACFb,'bx','linewidth',2)
plot(Lags,ACFub,'ko','linewidth',2)
legend('Matlab','Biased','Unbiased')

%% probability densilty function

y = rand(1,1e4) ;

% [p,xi,u] = ksdensity(y) ;
u = 0.1;
[p,xi] = ksdensity(y,'width',u,'kernel','box') ;

% p_norm = normpdf(xi,mean(y),std(y)) ;
figure()
plot([0 0 1 1],[0 1 1 0],'k','linewidth',2)
% plot(xi,p_norm,'k--','linewidth',2)
hold on
grid on
plot(xi,p,'r','linewidth',2)
xlabel('y')
ylabel('p(y)')
title('Probability density function')

[p,xi] = dou_pdf(y,u) ;

plot(xi,p,'b','linewidth',2)
legend('uniform','matlab','definition')