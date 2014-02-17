clc ;  close all ;
%% Generate Data 
%%  One sample 
% t = 1e6 ; 
% open( 'sys.mdl') ; 

% n = 1e4; 
% sim('sys.mdl')
% plot(measuredData(1:n))
% hold on
% plot(GaussianProcess(1:n),'k-.');

% Time 
% title('Time Response' ) ;
% % 
% fileID = fopen('TimeResponse1e6.txt','w') ;
% fprintf(fileID,'%10.6f \r\n',yout(:,1));
% fclose(fileID) ; 
% 
% fileID = fopen('GaussianSeries1e6.txt','w') ;
% fprintf(fileID,'%10.6f \r\n',yout(:,1));
% fclose(fileID) ; 

%% Histogram
% figure() 
% num_bin = 30;
% [counts, bins] = hist(yout,num_bin);
% num_data = numel( yout ) ;
% plot( bins, counts./num_data,'linewidth',2) ;
% legend('Linear Transformed Siganl')
% grid on 
% figure()
% h = cdfplot(measuredData(1:n) ) ; 
% set( h, 'linewidth',2) 


%% Ensemble Data
samplePeriod = 10000 ; 
ensembleTimes = 1e3 ; 
w = zeros( samplePeriod , ensembleTimes) ;

for i = 1 : ensembleTimes 
    sim('sys.mdl');
    w(:,i) = measuredData(1:samplePeriod,1)  ; 
end

% figure() ; 
% plot( w ) ;
% title('All samples') ;
%
% ensemble = w( 50, : ) ;
% figure() ; 
% plot( ensemble ) ;
% title('At specific time') ; 
% 
% figure()
% [counts, bins] = hist(ensemble,10);
% num_data = numel( ensemble(:,1) ) ;
% plot( bins, counts./num_data ) ;
% title('PDF of ensembled data' ) ;









