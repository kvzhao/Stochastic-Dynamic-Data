clc
clear all

MCS = 1e3 ;
t = [0:100]' ;

TF1out = nan * ones(length(t),MCS) ;
TF2out = nan * ones(length(t),MCS) ;

for i = 1:MCS
    x = normrnd(0,1,length(t),1) ;
    [nouse1,nouse2,TF1out(:,i),TF2out(:,i)] = sim('BlockDiagram');
end

timeStart = 20 ; timeEnd = 100;
mu_1 = mean(TF1out(timeStart:timeEnd,:)') ;
sigma_1 = std(TF1out(timeStart:timeEnd,:)') ;

mu_2 = mean(TF2out(timeStart:timeEnd,:)') ;
sigma_2 = std(TF2out(timeStart:timeEnd,:)') ;


figure()
plot(t(timeStart:timeEnd),mu_1,'b','linewidth',2)
hold on
plot(t(timeStart:timeEnd),mu_2,'r','linewidth',2)
grid on
xlabel('$\t$','Interpreter','latex','fontsize',14)
ylabel('$\mu_y$','Interpreter','latex','fontsize',14)
title('$\mu_y-t$','Interpreter','latex','fontsize',14)
legend('1st Order filter','2nd Order filter','Interpreter','latex');

figure()
plot(t(timeStart:timeEnd),sigma_1,'b','linewidth',2)
hold on
plot(t(timeStart:timeEnd),sigma_2,'r','linewidth',2)
grid on
xlabel('$\t$','Interpreter','latex','fontsize',14)
ylabel('$\sigma_y$','Interpreter','latex','fontsize',14)
title('$\sigma_y-t$','Interpreter','latex','fontsize',14)
legend('1st Order filter','2nd Order filter','Interpreter','latex');

% figure()
% plot(t,TF1out(:,2),'r','linewidth',2)
% hold on
% plot(t,TF2out(:,2),'b','linewidth',2)
% grid on
% xlabel('$\t$','Interpreter','latex','fontsize',14)
% ylabel('$y$','Interpreter','latex','fontsize',14)
% title('$Time Response$','Interpreter','latex','fontsize',14)


%%

% nLags = 90 ;
% autocorr(TF1out,nLags) 
% autocorr(TF2out,nLags) 
% autocorr(TF1out([10:end]),nLags) 
% autocorr(TF1out([1e4:end]),nLags) 