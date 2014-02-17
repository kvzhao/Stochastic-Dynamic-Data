clc
clear all
close all

% % freq = 0.01:0.01:100 ;
% 
% [z,p,k] = buttap(2) ;
% TF = zpk(z,p,k) ;
% %  [mag,phase] = bode(TF,freq) ;
% % MagdB = 20*log10(mag(:)') ;
% 
% % figure(1)
% % semilogx(freq,MagdB,'linewidth',2)
% % grid on
% % xlabel('Frequency(rad/sec)')
% % ylabel('Magnitude(dB)')
% 
% N = 1e5 ;
% n = 50 ;
% 
% x = normrnd(0,1,N,n);
% y = NaN * ones(N,n);
% 
% for i = 1:N
%     y(i,:) = lsim(TF,x(i,:),[1:n]-1) ;
% end
% save data
%
load data
alpha = 0.05;
for i = 1:size(x,2)
    xt = x(:,i) ;
    yt = y(:,i) ;
    
    hxl(i) = lillietest(xt,alpha) ;
    hyl(i) = lillietest(yt,alpha) ;
    
    hxj(i) = jbtest(xt,alpha) ;
    hyj(i) = jbtest(yt,alpha) ;
end

dx = 0.1 ;
x_interval = -5:dx:5 ;
y_interval = -3:dx:3 ;

[y_hist x_hist] = hist(xt,x_interval) ;
figure()
bar(x_hist,y_hist/length(xt)/dx) ;
h = findobj(gca,'Type','patch');
set(h,'FaceColor','b','EdgeColor','w')

[y_hist x_hist] = hist(yt,y_interval) ;
figure()
bar(x_hist,y_hist/length(yt)/dx) ;
h = findobj(gca,'Type','patch');
set(h,'FaceColor','b','EdgeColor','w')

%

Ns = [1e3 1e4 1e5] ;
alpha = 0.05 ;

for i = 1:length(Ns)
    [hx(i),px(i),CIx(:,i)] = ztest(x([1:Ns(i)],50),0,1,alpha) ;
    mx = sum(CIx)/2 ;
    [hy(i),py(i),CIy(:,i)] = ttest(y([1:Ns(i)],50),0,alpha) ;
    my = sum(CIy)/2 ;
end

figure()
errorbar([3 4 5],mx,abs(CIx(1,:)-mx),abs(CIx(2,:)-mx),'o','linewidth',2)
hold on
plot([2.5 5.5],[0 0 ],'k--','linewidth',2)
xlabel('number of samples(10^n)')
ylabel('x')

figure()
errorbar([3 4 5],my,abs(CIy(1,:)-my),abs(CIy(2,:)-my),'o','linewidth',2)
hold on
plot([2.5 5.5],[0 0 ],'k--','linewidth',2)
xlabel('number of samples(10^n)')
ylabel('y')

%
Ns = 1e3 ;
alpha = [0.05 0.1 0.25] ;

for i = 1:length(alpha)
    [hx(i),px(i),CIx(:,i)] = ztest(x([1:Ns],50),0,1,alpha(i)) ;
    mx = sum(CIx)/2 ;
    [hy(i),py(i),CIy(:,i)] = ttest(y([1:Ns],50),0,alpha(i)) ;
    my = sum(CIy)/2 ;
end

figure()
errorbar(alpha,mx,abs(CIx(1,:)-mx),abs(CIx(2,:)-mx),'o','linewidth',2)
hold on
plot([0 0.35],[0 0 ],'k--','linewidth',2)
xlabel('significance level(\alpha)')
ylabel('x')

figure()
errorbar(alpha,my,abs(CIy(1,:)-my),abs(CIy(2,:)-my),'o','linewidth',2)
hold on
plot([0 0.35],[0 0 ],'k--','linewidth',2)
xlabel('significance level(\alpha)')
ylabel('y')

%%
xt = normrnd(0,1,1e6,1) ;
yt = lsim(TF,xt,[1:length(xt)]-1) ;
yt(1:100) = [] ;

alpha = 0.05 ;
method =2 ;
runstest(xt)
checkstationary(yt,100,alpha,method)
