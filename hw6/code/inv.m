%% Verification of Invariant properties
sim('sys') ; 
n = 1e4; 
% SCATTER HIST--------------------------------------------------------
figure() 
scatterhist( GaussianProcess(1:n), measuredData(1:n))
xlabel('Gaussian Process' , 'fontsize',14);
ylabel('Measured Data' , 'fontsize',14);
title('Scatter Histogram','fontsize',14) ; 

% HIST  -----------------------------------------------
figure() 
histfit( GaussianProcess(1:n) ) ; 
xlabel('Gaussian Process' , 'fontsize',14);
title('Input Histogram','fontsize',14) ; 

figure() 
histfit( measuredData(1:n)  ) ; 
xlabel('Measured  Data' , 'fontsize',14);
title('Output Histogram','fontsize',14) ; 

%normal scores plot-----------------------------------------------
figure() 
probplot( GaussianProcess(1:n)  )  ; 
xlabel('Gaussian Process' , 'fontsize',14);
title('Normal Scores plot','fontsize',14) ; 
grid on 
figure() 
probplot( measuredData(1:n)  ) ; 
xlabel('Measured  Data' , 'fontsize',14);
title('Normal Scores plot','fontsize',14) ; 
grid on 