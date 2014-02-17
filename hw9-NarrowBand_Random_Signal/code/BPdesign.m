clc ; clear all; close all ; 

%% DATA GENERATION
order = 12;
N = 2^order ; 

% sigma=1; mu=0; 
% x = normrnd(mu,sigma,N,1);

p = 10 ;  imp = 5; 
x = wgn(N,1,p,imp) ; 

%% FILTER DESIGN

B = 0.5 * 0.01 / (2*pi) ;
f0 = 0.5 / (2*pi) ;
k = 1 ; 
Fs = 10;

num = [k 0] ;
den = [1 2*pi*B (pi*B)^2+(2*pi*f0)^2] ;

H_low = tf(num,den) ;
w = 1e-3 :.01: 1e1;
[mag,phase] =  bode(H_low,w);
MagdB = 20*log10(mag(:)) ;
Phase = phase(:);
% bode plot
figure()
semilogx(w,MagdB,'r','Linewidth',2)
title('BODE plot','fontsize',14);
xlabel('frequency( rad/sec )','fontsize',14); ylabel('Magtitude ( dB )','fontsize',14');
grid on


hold on 
% Comparision w diff filter
k = 1000;
num = [k 0] ;
H_high = tf(num,den) ;
[mag,phase] =  bode(H_high,w);
MagdB = 20*log10(mag(:)) ;
semilogx(w,MagdB,'--b','Linewidth',2)
legend('k=1','k=1000','fontsize',8,'Interpreter','latex')

% Phase
figure()
semilogx(w,Phase,'r','Linewidth',2)
title('BODE plot','fontsize',14);
xlabel('frequency( rad/sec )','fontsize',14); ylabel('Phase( deg )','fontsize',14');
grid on

% PZmap
[p,z] = pzmap(H_low);
figure()
plot( p ,'rx','Linewidth',2,'MarkerSize',10) ; hold on 
plot( 0, z ,'o','Linewidth',2,'MarkerSize',10) 
title('Pole -Zero Diagram','fontsize',14);
xlabel('$\sigma$','fontsize',14,'Interpreter','latex'); ylabel('$j\omega$','fontsize',14','Interpreter','latex');
xmin = -.005 ; xmax = .005 ; ymin = -.7; ymax=.7;
axis([xmin,xmax,ymin,ymax]) 
hold on 
line([0 0],[ymin ymax],'LineWidth',1) ; 
hold on 
line([xmin xmax],[0 0],'LineWidth',1) ; 
grid on 

%% DATA ANALYSIS

Tfinal = N-1 ; 
dt = 1; 

t = 0:dt:Tfinal;

y = lsim(H_high,x,t);

% Stationary
tss = 2049:length(y);
yss = y(tss) ; 

% dont care 
% tss =t;
% yss = y ; 

figure()
plot(tss,yss,'--r','linewidth',2);
title('Stationary Narrow-Band Random Signal ','fontsize',14);
xlabel('Time (sec) ','fontsize',14,'Interpreter','latex'); ylabel('Signal y(t)','fontsize',14','Interpreter','latex');
axis tight

% my_FFT(yss,Fs)

%AUTOcorrelation
Ry = xcorr(yss,'biased');
my_FFT(Ry,Fs);

data_length = ceil(length(Ry)/2-1);
tau = -data_length : data_length ; 
figure() 
plot(tau,Ry);
title('AutoCorrelation function','fontsize',14);
xlabel('$\tau$','fontsize',14,'Interpreter','latex'); ylabel('$R_{xx}$','fontsize',14','Interpreter','latex');

% Spectrum
my_FFT(Ry,Fs);


% Ideal Distribution  
% std_y = std(yss);

%dont care nonstationary 
std_y = std(y);

t = 1:data_length ;
R = raylrnd(std_y,1,10*data_length) ;

histfit(R,100,'rayleigh')
title('Distribution of R','fontsize',14);

my_Gxx(R,Fs);
theta = pi*rand(1,10*data_length) - pi/2;
% theta = 2*pi*rand(1,10*data_length) ;

z = R(10*t) .* cos(0.5*t + theta(10*t));

Rz = xcorr( z,'biased' ) ;

figure() 
data_length = ceil(length(Rz)/2-1);
tau = -data_length : data_length ; 

plot(tau,Rz);

title('AutoCorrelation function','fontsize',14);
xlabel('$\tau$','fontsize',14,'Interpreter','latex'); ylabel('$R_{xx}$','fontsize',14','Interpreter','latex');
my_Gxx(Rz,Fs);
% my_FFT(Rz,Fs);

%% DATA VERIFICATION
figure() 
time_step = 20;

data_length = ceil(length(Rz)/2-1);
tau = -data_length : data_length ; 
plot(tau(1:time_step:end),Rz(1:time_step:end),'r','linewidth',1.5); hold on 

data_length = ceil(length(Ry)/2-1);
tau = -data_length : data_length ; 

plot(tau(1:time_step:end),Ry(1:time_step:end),'--','linewidth',1.5);
title('Autocorrelation function','fontsize',14,'Interpreter','latex');
legend('Numerical Verification Data','Narrow-Band Simulation Data')

    figure()
    L = length(Rz);
    NFFT = 2^nextpow2(L); % Next power of 2 from length of y
    Sxxz = fft(Rz,NFFT)/L;
    f = Fs/2*linspace(0,.1,NFFT/2+1);

    % Plot single-sided amplitude spectrum.

    offset = 10*log10(2);
    plot(f,10*log10(abs(Sxxz(1:NFFT/2+1) ) )+offset,'r','LineWidth',1.5) ;hold on 

    title('Single-Sided Power Spectrum','fontsize',14)
   
    xlabel('Frequency (rad/sec)  (Linear) ','fontsize',14)
    ylabel('Magnitude (dB) ','fontsize',14);
    grid on
    
     L = length(Ry);
    NFFT = 2^nextpow2(L); % Next power of 2 from length of y
    Sxxy = fft(Ry,NFFT)/L;
    
    f = Fs/2*linspace(0,.1,NFFT/2+1);

    % Plot single-sided amplitude spectrum.
    offset = 10*log10(2);
    plot(f,10*log10(abs(Sxxy(1:NFFT/2+1) ) )+offset,'--','LineWidth',1.5) 
    
legend('Numerical Verification Data','Narrow-Band Simulation Data')