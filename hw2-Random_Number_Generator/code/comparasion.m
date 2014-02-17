clc  ; clear all ; close all ; 
%% Comparing MATLAB function with self-defined function

N =5000 ; 
rNum = rand(N,1) ; 

r = lc_rand(N) ; 

%% Distribution
% figure(1)
% plot( rNum ,'-o','linewidth',2) ; 
% m = mean( rNum ) ; 
% hold on 
% plot([0 N],[m m],'g--','linewidth',2)
% 
% ylabel('x') ; xlabel('Time') ;
% title('MATLAB rand()')
% 
% %%
% figure(2)
% plot( r ,'-or','linewidth',2) ; 
% m = mean( r ) ; 
% hold on 
% plot([0 N],[m m],'g--','linewidth',2)
% ylabel('x') ; xlabel('Time') ;
% title('MY lc\_rand()')

%% Histogram
figure(3)
hist(rNum,30);
ylabel('Frequency') ; xlabel('x') ;
title('MATLAB rand()')

h = findobj(gca,'Type','patch');
set(h,'EdgeColor','w')
%%
figure(4)
hist(r,30);
ylabel('Frequency') ; xlabel('x') ;
title('MY lc\_rand()')

h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','w')



