


%% find convergence rate 

order = 1 : .25 :6 ; 
n = ceil( 10.^order ) ; 
dev = 1 ; mu = 0 ; 

mu_x = zeros( length(n),1) ; 
std_x = zeros( length(n),1) ; 

for i = 1:length(n) ;
    x = gaussian_dist(mu,dev,n(i)) ;
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