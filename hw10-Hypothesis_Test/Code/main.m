clc ; clear all ; close all ;
%% Signal Generator

n = 1e5;
std = 1 ; mean=0;
x = normrnd(mean,std,n,1);
% x = wgn(n,1,10);

% filtering System
    order =2;
    [z,p,k] = buttap(order);
    sys = zpk(z,p,k);
    
%      --- Bode--- 

%     freq = .01 : .01 : 100;
%     [mag,phase] = bode(sys,freq);
%     MagdB = 20*log10(mag(:));
%     plot
%     figure()
%     semilogx(freq,MagdB,'r','Linewidth',2)
%     title('BODE plot','fontsize',14);
%     xlabel('frequency( rad/sec )','fontsize',14); ylabel('Magtitude ( dB )','fontsize',14');
%     grid on

% filter
dt = 1; 
Tfinal = n*dt ;  
t = 0:dt:Tfinal-dt;

y = lsim(sys,x,t);

% Data Partition 
nTest =50;
nSample = n/nTest; 

y_s = zeros(nSample,nTest);
for i = 1 : 1 : nTest
    y_s(:,i) = y( (i-1)*nSample+1 : i*nSample);
end
    

%% Lilliefors & Jarque-Bera Test
figure()

% plotting with different alpha
alpha = 0.2;
h_l = zeros(nTest,1);
h_jb = zeros(nTest,1);
for i = 1 : 1 : nTest
    h_l(i) = lillietest(y_s(:,i),alpha);
    h_jb(i) = jbtest(y_s(:,i),alpha);
end

subplot(211)
plot(h_l,'linewidth',2); hold on ; 

plot(h_jb,'--r','linewidth',2);

xmax = nTest; xmin=0; ymax = 2; ymin = -1;
axis([xmin,xmax,ymin,ymax]);
title('Significant Level  $\alpha = 0.2$','interpreter','latex','fontsize',14);
ylabel('Logic Value','interpreter','latex','fontsize',14);
sum(h_l)
sum(h_jb)

alpha = 0.05;

for i = 1 : 1 : nTest
    h_l(i) = lillietest(y_s(:,i),alpha);
    h_jb(i) = jbtest(y_s(:,i),alpha);
end
% figure()
subplot(212)
plot(h_l,'linewidth',2); hold on ; 
plot(h_jb,'--r','linewidth',2);
axis([xmin,xmax,ymin,ymax]);
legend('Lilliefors Test','Jarque-Bera Test');

title('Significant Level $\alpha = 0.05$','interpreter','latex','fontsize',14);
ylabel('Logic Value','interpreter','latex','fontsize',14);
xlabel('\# Sections','interpreter','latex','fontsize',14);
sum(h_l)
sum(h_jb)


%%  Hypothesis test on Mean Estimation , z-test and t-test
% 
% significant level
alpha = .05;

% z - test 
Ns = [1e3 1e4 1e5] ;
hz = zeros(length(Ns));
pz = zeros(length(Ns));
CIz = zeros(2,length(Ns));

% t - test 
ht = zeros(length(Ns));
pt = zeros(length(Ns));
CIt = zeros(2,length(Ns));

% Different sample number 
for i = 1 : length(Ns)
    [hz(i),pz(i),CIz(:,i)] = ztest( y( 1:Ns(i) ) , mean,std,alpha);
    [ht(i),pt(i),CIt(:,i)] = ttest( y( 1:Ns(i) ) , mean,alpha);
end
mz = sum( CIz )/2;
mt = sum( CIt )/2;

figure();

subplot(121)
errorbar([3 4 5],mz,abs(CIz(1,:)-mz),abs(CIz(2,:)-mz),'o','linewidth',2)
xlabel('Number of Sample $(10^n)$','interpreter','latex','fontsize',14);ylabel('Value','interpreter','latex','fontsize',14);
hold on 
plot([2.5,5.5],[0,0],'--k','linewidth',2)
legend('Estimated Mean','Ideal Mean Value')
title('Confident Interval by Z-test ','interpreter','latex','fontsize',14)
axis([2.5,5.5,-.1,.1]);

subplot(122)
errorbar([3 4 5],mt,abs(CIt(1,:)-mt),abs(CIt(2,:)-mt),'ro','linewidth',2)
xlabel('Number of Sample $(10^n)$','interpreter','latex','fontsize',14);ylabel('Value','interpreter','latex','fontsize',14);
hold on 
plot([2.5,5.5],[0,0],'--k','linewidth',2)
axis([2.5,5.5,-.1,.1]);

legend('Estimated Mean','Ideal Mean Value')
title('Confident Interval by Student-test','interpreter','latex','fontsize',14)

% DIFFERENT ALPHA
Ns = 1e4;
alpha = [ .05 .1 .25];

% Different sample number 
for i = 1 : length(alpha)
    [hz(i),pz(i),CIz(:,i)] = ztest( y( 1:Ns ) , mean,std,alpha(i));
    [ht(i),pt(i),CIt(:,i)] = ttest( y( 1:Ns ) , mean,alpha(i));
end
mz = sum( CIz )/2;
mt = sum( CIt )/2;

figure();

subplot(121)
errorbar(alpha,mz,abs(CIz(1,:)-mz),abs(CIz(2,:)-mz),'o','linewidth',2)
xlabel('Significant Level $\alpha$','interpreter','latex','fontsize',14);ylabel('Value','interpreter','latex','fontsize',14);
hold on 
plot([0,.3],[0,0],'--k','linewidth',2)

legend('Estimated Mean','Ideal Mean Value')
title('Confident Interval by Z-test ','interpreter','latex','fontsize',14)
axis([0,.3,-.05,.05]);

subplot(122)
errorbar(alpha,mt,abs(CIt(1,:)-mt),abs(CIt(2,:)-mt),'ro','linewidth',2)
xlabel('Significant Level $\alpha$','interpreter','latex','fontsize',14);ylabel('Value','interpreter','latex','fontsize',14);
hold on 
plot([0,.3],[0,0],'--k','linewidth',2)
axis([0,.3,-.05,.05]);

legend('Estimated Mean','Ideal Mean Value')
title('Confident Interval by Student-test','interpreter','latex','fontsize',14)

%% Hypothesis test on stationarity

alpha = 0.05 ;
method =1 ;

% h_r = zeros(nTest,1);
% for i = 1 : 1 : nTest
%     h_r(i) = runstest(y_s(i),alpha);
% end
% plot(h_r)

timeSpan=2000;
NN = 100;

checkstationary(y_s(1:timeSpan,10),NN,alpha,method);
% checkstationary(y_s(1:timeSpan,3),NN,alpha,method);



