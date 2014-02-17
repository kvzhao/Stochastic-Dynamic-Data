clc; close all; clear all; 

%% PROCESS
% num = .25 ; 
% den = [1 0.7071 0.25];
% H = tf(num,den);

%% SIGNAL
N = 1e4;
% mu = 0; sigma = 1 ; 
% x = normrnd(mu,sigma,N,1);

%% TIME RESPONSE
% timeStep = 1 ;
% t = 0 : timeStep : N -timeStep ; 
% y = lsim(H,x,t);

% Nonstationary part
% y = y( 50:end);

%% PDF COMPARISON
% [p,yi] = ksdensity(y);
% muy =  mean(y);
% stdy = std(y);
% np = normpdf(yi,muy,stdy);
% % Gaussian dist 
% plot(yi,p,'r','linewidth',2);
% hold on ;
% plot(yi,np,'--k','linewidth',2);
% 
% title('Probability Density Function','interpreter','latex','fontsize',14);
% xlabel('$y$','interpreter','latex','fontsize',14);ylabel('$p(y)$','interpreter','latex','fontsize',14);
% legend('Output Signal Distribution(Matlab)','Ideal Distribution','interpreter','latex','fontsize',14)

%% COMPARE AUTOCORRELATION FUNC
% nLag = 40;
% ACF_unbiased = myAutoCorr(y,nLag,'unbiased');
% [ACF_biased ,lags] = myAutoCorr(y,nLag,'biased');
% ACF = xcorr(y,nLag,'unbiased');
% figure();
% % plot(lags,ACF(nLag+1:end),'--','linewidth',1.5); hold on ; 
% stem(lags,ACF(nLag+1:end),'linewidth',1.5);hold on ; 
% plot(lags,ACF_unbiased,'*r','linewidth',1.5); hold on ;
% plot(lags,ACF_biased,'ok','linewidth',1.5); 
% legend('MATLAB function','Unbiased Estimator','Biased Estimator');
% xlabel('Time Lag (sec)','interpreter','latex','fontsize',14); ylabel('$R_{xx}$','interpreter','latex','fontsize',14)
% title('Correlogram','interpreter','latex','fontsize',14)

%% =================================================================
%  figure(); plot(xcorr(y,20,'biased'),'*'); hold on ; plot(xcorr(y,20,'unbiased'),'ro')
%% =================================================================

%% UNIFORM PROCESS

%% SIGNAL
% N = 1e4;
% y = rand(N,1);

%% PDF COMPARISON
% % uniform dist 
% figure()
% plot([0 0 1 1],[0 1 1 0],'k','linewidth',2) ; hold on ; 
% u = .01; 
% [pi,yi] = ksdensity(y,'width',u,'kernel','box') ; hold on ;
% plot(yi,pi,'r','linewidth',2); hold on; 
% [p,xi] = EstDensity(y,u);
% plot(xi,p,'linewidth',2);
% title('Probability Density Function','interpreter','latex','fontsize',14);
% xlabel('$y$','interpreter','latex','fontsize',14);ylabel('$p(y)$','interpreter','latex','fontsize',14);
% legend('Ideal Distribution','Matlab Density Estimator','Self-Defined Estimator','interpreter','latex','fontsize',14)
% grid on ;

%% COMPARE DIFFERENT ESTIMATOR
%% PROCESS
num = 1 ; 
den = [1 0.7071 0.25];
H = tf(num,den);

%% SIGNAL
mu = 0; sigma = 1 ; 
x = normrnd(mu,sigma,N,1);

% TIME RESPONSE
timeStep = 1 ;
t = 0 : timeStep : N -timeStep ; 
y = lsim(H,x,t);

figure();

u =  std(y)*.2; 
% u =     0.3017;
[p,yi] = ksdensity(y);
% plot(yi,p,'r','linewidth',2); hold on ; 

muy =  mean(y);
stdy = std(y);
np = normpdf(yi,muy,stdy);
% Gaussian dist 
plot(yi,np,'--k','linewidth',2);

[pp,xi] = EstDensity(y,u); 
hold on ;
plot(xi,pp,'linewidth',2);

title('Probability Density Function','interpreter','latex','fontsize',14);
xlabel('$y$','interpreter','latex','fontsize',14);ylabel('$p(y)$','interpreter','latex','fontsize',14);
% legend('Kernal Smoother Estimator(Matlab)','Ideal Gaussian Distribution','Self Defined Estimator','interpreter','latex','fontsize',14)
legend('Ideal Gaussian Distribution','Self Defined Estimator','interpreter','latex','fontsize',14)
grid on ; 

%% Error function modeling
x_val = -2 : .01 : 3 ;
px = np(50); 
c = 1;  p2 = np(51)+np(49)-2*px;
% c1 = c^2/N ; 
% c2 = 1/576*(1/px)^2;
c1=1e-6;c2 = 1e-6 ; 

err = c1*x_val.^-1 + c2*x_val.^4;
figure();
plot(x_val,err);


%% ARMA model 

% T = 0.01 ; % sec 
% Dz = c2d(H,T,'zoh');
% 
% b = [ 1.247e-005, 1.243e-005]  % AR coef
% a = [1,  - 1.993, 0.993]; 
% 
% arma_y = filter(b,a,x);
% [ACF ,lags] = myAutoCorr(arma_y,100,'unbiased');
% %  [c lags]=xcov(arma_y,nLag,'biased');
% %  c = c + mean(arma_y)^2; 
%  figure;plot(lags,ACF);title('SampleCovariances');

%% 2D estimation 
% % Matlab function - Kernel Smoother 
% figure()
% % Estimate a continuous pdf from the discrete data
% [pdfx xi]= ksdensity(x);
% [pdfy yi]= ksdensity(y);
% % Create 2-d grid of coordinates and function values, suitable for 3-d plotting
% [xxi,yyi]     = meshgrid(xi,yi);
% [pdfxx,pdfyy] = meshgrid(pdfx,pdfy);
% % Calculate combined pdf, under assumption of independence
% pdfxy = pdfxx.*pdfyy; 
% % Plot the results
% mesh(xxi,yyi,pdfxy)
% set(gca,'XLim',[min(xi) max(xi)])
% set(gca,'YLim',[min(yi) max(yi)])
% title('Probability Density Function - Kernel Smoother','interpreter','latex','fontsize',14);
% xlabel('$x$','interpreter','latex','fontsize',14); ylabel('$y$','interpreter','latex','fontsize',14)
% zlabel('$p(x,y)$','interpreter','latex','fontsize',14);
% 
% % Self-Defined Function
% figure()
% u=.1;
% % Estimate a continuous pdf from the discrete data
% [pdfx xi]= EstDensity(x,u);
% [pdfy yi]= EstDensity(y,u);
% % Create 2-d grid of coordinates and function values, suitable for 3-d plotting
% [xxi,yyi]     = meshgrid(xi,yi);
% [pdfxx,pdfyy] = meshgrid(pdfx,pdfy);
% % Calculate combined pdf, under assumption of independence
% pdfxy = pdfxx.*pdfyy; 
% % Plot the results
% mesh(xxi,yyi,pdfxy,'FaceLighting','gouraud')
% set(gca,'XLim',[min(xi) max(xi)])
% set(gca,'YLim',[min(yi) max(yi)])
% title('Probability Density Function','interpreter','latex','fontsize',14);
% xlabel('$x$','interpreter','latex','fontsize',14); ylabel('$y$','interpreter','latex','fontsize',14)
% zlabel('$p(x,y)$','interpreter','latex','fontsize',14);
% colormap cold