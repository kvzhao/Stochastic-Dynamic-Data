clc ; clear all ; close all 
%% Gaussian Sequences
mu = 3 ; dev = 2 ; 
% n = 1e5 ; 
% x  = normrnd( mu,dev,n ,1) ;
% x = gaussian_dist(mu,dev,n) ; 
%% ploting 
% figure() 
% plot(x,'-o','linewidth',2) ;
% hist(x,80)
% title('Gaussian Sequence','Interpreter','latex','fontsize',14) ;
% xlabel('t','Interpreter','latex','fontsize',14); 
% ylabel('$x(t)$','Interpreter','latex','fontsize',14);
% grid on 
% autocorr(x)
%% find convergence rate 
order = 1 : .25 :6 ; 
n = ceil( 10.^order ) ; 
mu_x = zeros( length(n),1) ; 
std_x = zeros( length(n),1) ; 
z  = dev + mu;

for i = 1:length(n) ;
    x = normrnd(0,z,n(i),1) ;
    mu_x(i) = mean(x) ;
    std_x(i) = std(x,1) ;
end

figure()
semilogx(n,mu_x,'b-','linewidth',2)
hold on
semilogx(n([1 end]),mu*ones(1,2),'r-.','linewidth',2)
xlabel('Number of samples')
ylabel('$\hat \mu_x$','Interpreter','latex','fontsize',14)
title('$\hat \mu_x$-N','Interpreter','latex','fontsize',14)
grid on

figure()
semilogx(n,std_x,'b-','linewidth',2)
hold on
semilogx(n([1 end]),dev*ones(1,2),'r-.','linewidth',2)
xlabel('Number of samples','Interpreter','latex','fontsize',14)
ylabel('$\hat \sigma_x$','Interpreter','latex','fontsize',14)
title('$\hat \sigma_x$-N','Interpreter','latex','fontsize',14)
grid on