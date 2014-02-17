clc
clear all

n = 1e6 ;
dx = 0.1 ;
x_interval = -10:0.1:16 ;

mu = 0;
sigma = 1 ;

P = rand(1,n) ;
x = mu + sqrt(2) * sigma * erfcinv(2-2*P) ;
[yout xout] = hist(x,x_interval);
p = exp(-(x_interval-mu).^2/2/sigma^2) / sigma/sqrt(2*pi) ;

figure()
bar(xout,yout/n/dx,'hist')
h = findobj(gca,'Type','patch');
set(h,'FaceColor','b','EdgeColor','w')
hold on
plot(x_interval,p)
xlabel('$x$','Interpreter','latex','fontsize',14)
ylabel('$p(x)$','Interpreter','latex','fontsize',14)
title('probability density function')

bar(xout,yout/n/dx,'hist')
h = findobj(gca,'Type','patch');
set(h,'FaceColor','b','EdgeColor','w')
hold on
plot(x_interval,p,'r','linewidth',2)
xlabel('$x$','Interpreter','latex','fontsize',14)
ylabel('$p(x)$','Interpreter','latex','fontsize',14)
title('probability density function')

mu = 3;
sigma = 2 ;

P = rand(1,n) ;
x = mu + sqrt(2) * sigma * erfcinv(2-2*P) ;
[yout xout] = hist(x,x_interval);
p = exp(-(x_interval-mu).^2/2/sigma^2) / sigma/sqrt(2*pi) ;


bar(xout,yout/n/dx,'hist')
h = findobj(gca,'Type','patch');
set(h,'FaceColor','b','EdgeColor','w')
hold on
plot(x_interval,p,'r','linewidth',2)
xlabel('$x$','Interpreter','latex','fontsize',14)
ylabel('$p(x)$','Interpreter','latex','fontsize',14)
title('probability density function')

bar(xout,yout/n/dx,'hist')
h = findobj(gca,'Type','patch');
set(h,'FaceColor','b','EdgeColor','w')
hold on
plot(x_interval,p,'r')
xlabel('$x$','Interpreter','latex','fontsize',14)
ylabel('$p(x)$','Interpreter','latex','fontsize',14)
title('probability density function')

