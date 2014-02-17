clc 
clear all
close all

%% Estimation pi the parameter N
% figure() 
% order = 0 : .5 : 6 ;
% n = floor(10.^order) ; 5
% epi = zeros(length(n),1) ; 
% for i = 1 : length(n)
%     epi(i) = BuffonsNeedle(n(i),1,1) ;
% end
% semilogx(n,epi,'-o','linewidth',2) 
% hold on 
% semilogx(n([1 end]),pi*ones(1,2),'r--','linewidth',2)
% title(' Estimation of pi value') ; xlabel('# of needles') ; ylabel('estimation pi') ;
% 
% error = abs( epi - pi ); 
% figure() 
%     semilogx(n,error,'r--','linewidth',2)
% title('ERROR of estimation') ; 

%% Estimation pi the parameter (L/D)

% LDratio = 1 ; 
% nconv = zeros(100,1) ; 
% for i = 1:100
%     nconv(i) = nConverge( LDratio , 1e-2 ) ; 
% end
% histfit(nconv)
% hold on
% % hist(nconv,[1000:500:12000])
% % histfit(nconv,'Rayleigh')
% mean(nconv) 
% title('Histogram of L/D ratio is 1') ; 

ratio = 0 : .025 : 1 ;
avg = zeros(length(ratio),1) ; 
for j = 1 : length(ratio)
 
    nconv = zeros(100,1) ; 
    for i = 1:100
        nconv(i) = nConverge( ratio(j) , 1e-2 ) ; 
    end
    
    avg(j) = mean(nconv) ; 
end

plot(ratio(2:end),avg(2:end),'-o','linewidth',2) ; 
xlabel('L/D ratio') ; ylabel('N # of tossed needles') 
title('Estimated \pi under tolerance ~0.01');




