close all ; clc; 
%% Ergodicity 
% load ws.mat
load w.mat

% w = w' ; 
% find nonstationary part --------------------------------------------

% trial 
% ensembleAvg = sum( w )./1e4; 
% plot( ensembleAvg ) 
% hold on 
% plot( w(3,:)/100 ,'r') 

%% find nonstationary
% snum = ceil(rand()*1000) ; 
% sample = w(:,snum) ; 
% for t = 1 : 1000 
%     time_mean = mean( sample(1:t) )/t ; 
%     hold on 
%     plot( .1*t, time_mean ,'.') ; 
% end
% xlabel('$Time$','Interpreter','latex','fontsize',14)
% ylabel('$\mu_y$','Interpreter','latex','fontsize',14)
% title('$\mu_y-t$','Interpreter','latex','fontsize',14)
% grid on


%% ERGODIC VERYFICATION
snum=1;
duration = 999 ; 
single_sample = sum( w( 2000:10000 , 1:end) ,2)/1000  ;

% figure() 
% histfit( single_sample ) 
% xlabel('$Values\ of\ Data$','Interpreter','latex','fontsize',14)
% ylabel('$\#\ of\ Data$','Interpreter','latex','fontsize',14)
% title('$Histogram\ of\ Ensemble\ Data$','Interpreter','latex','fontsize',14)
% axis([-1,1,0,350]) 
% mean(single_sample) 
% std(single_sample)


% ergodic_func = w( 2000:end , ceil(rand()*1000) )  ; 
% figure() 
% histfit(ergodic_func)
% xlabel('$Values\ of\ Data$','Interpreter','latex','fontsize',14)
% ylabel('$\#\ of\ Data$','Interpreter','latex','fontsize',14)
% title('$Histogram\ of\ One\ Sample\ Data$','Interpreter','latex','fontsize',14)
% axis([-1,1,0,350]) 

% std(ergodic_func) 
% t_smean = mean(ergodic_func)  ; 
% ens_mean = mean(  w( 2000:10000 , 1:end) ) ; 
% e = abs( ens_mean - t_smean ); 
% 
% plot(e,'--o','linewidth',2)
% axis([0,100,-.01,.05])
% grid on 
% 
% xlabel('\# of Samples','Interpreter','latex','fontsize',14)
% ylabel('Error Value','Interpreter','latex','fontsize',14)
% title('Error of each sample and time series','Interpreter','latex','fontsize',14)

%% THREE_D plot
x = w(3001:3050,51:100);
t = 50:99 ;
figure()
for i = 1:size(x,1)-20
    sample = i * ones(1,size(x,2)) ;
    if i == 13
        plot3(sample,t, x(:,i),'k','linewidth',2)
    else
        plot3(sample,t, x(:,i),'k')
    end
    
    hold on
end
grid on
title('Ergodic Proerties','Interpreter','latex','fontsize',14)
xlabel('sample','Interpreter','latex','fontsize',14)
ylabel('$t$','Interpreter','latex','fontsize',14)
zlabel('$x(t)$','Interpreter','latex','fontsize',14)
hold on 
star = zeros( size(x,1)-20,1) ; 
o = zeros( size(x,1)-20,1) ; 
for i = 1:size(x,1)-20
    sample = i * ones(1,size(x,2)) ;
    plot3(sample,70, x(20,i),'r*')
    plot3(sample,90, x(40,i),'bo')
    
    star(i) = x(20,i);
    o(i) = x(40,i);
    hold on
end

hold on 
t = ones(1,30) * 70 ; 
sample = 1:30;
plot3( sample(1:30) , t ,star ,'r' ,'linewidth',2) 
hold on 
t = ones(1,30) * 90 ; 
plot3( sample(1:30) , t ,o ,'b' ,'linewidth',2) 

% omega = w( 2000:end , ceil(rand()*1000)  )  ; 
% autocorr( omega(1000:5000) , 260 ) ; 
% autocorr( w(:,ceil(rand()*1000)),90) ; 
