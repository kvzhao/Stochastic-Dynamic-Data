clc ; clear all ; close all ; 
% %% Matlab RNG 
N =100 ; 
rNum = rand(N,1) ; 

%% Distribution
% figure(1)
% plot( rNum ,'-o','linewidth',2) ; 
% ylabel('x') ; xlabel('Time') ;
% title('Time-Series of random data x ')
% %% Histogram
% figure(2)
% hist(rNum);
% ylabel('Frequency') ; xlabel('x') ;
% title('Histogram of random data x ')
% 
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor','u','EdgeColor','w')

%% function testing
n = 1e4; 

r1 = lc_rand(n) ;
r2 = lc_rand2(n) ; 

% figure(1) ; 
% plot( r1 ,'-or','linewidth',2) ; 
% m = mean( r1 ) ; 
% hold on 
% plot([0 n],[m m],'g--','linewidth',2)
% ylabel('x') ; xlabel('Time') ;
% title('LCG 2')
figure(2) 
hist(r1,20);
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')
ylabel('Frequency') ; xlabel('x') ;
title('LCG 1')
% 
% figure(3) ; plot(r2) 
% plot( r2 ,'-o','linewidth',2) ; 
% m = mean( r2 ) ; 
% hold on 
% plot([0 n],[m m],'g--','linewidth',2)
% ylabel('x') ; xlabel('Time') ;
% title('MRG 2')

figure(4) 
hist(r2,20);
ylabel('Frequency') ; xlabel('x') ;
title('MRG 1')
