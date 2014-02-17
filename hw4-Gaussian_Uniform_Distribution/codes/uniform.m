clc ; clear all; close all ; 
n = 1e4 ; 
a = 1; 
b = 5 ; 
x = a + (b-a)*rand(n,1) ; 
xmin = 0 ; xmax = n ; 
ymin = -.5 ; ymax = 6 ; 
figure()
hist(x,20)
figure()
plot(x) ; 
hold on 
plot([0 n],[a a],'r--','linewidth',2');
hold on 
plot([0 n],[b b],'r--','linewidth',2');
axis([xmin, xmax, ymin, ymax])
grid on 
title('Uniform Sequence','Interpreter','latex','fontsize',14) ; 
