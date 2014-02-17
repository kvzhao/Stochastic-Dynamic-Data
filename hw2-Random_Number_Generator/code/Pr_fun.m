clc ; clear all ; close all ; 
%% probabilty of head toward # of coin

order = 0 : .25 : 6; 
n = ceil( 10.^order )  ; 

nf = zeros(1, length(n) ) ; 
p = nan * zeros(1, length(n) ) ; 

    for i = 1:length(n) 
        x = rand(1,n(i) ) ; 
        nf(i) = length( find( x >.5)  ) ; 
    end
    
   p(1,:) = nf ./n ;
   
 semilogx(n,p,'-o','Linewidth',2) 
 hold on 
 
semilogx([1 n(end)],[0.5 0.5],'r--','linewidth',2)

xlabel( '# of tossing coins')
ylabel( 'Probability of head') 
