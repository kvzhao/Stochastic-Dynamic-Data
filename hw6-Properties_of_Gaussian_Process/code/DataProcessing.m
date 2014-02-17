clc;  close all ; clear all
%% Data Processing
load TimeResponse1e6.txt ; 
load GaussianSeries1e6.txt ; 
load w.mat ; 
%% Time response
% figure() ; 
% t = 1:1000 ; 
% plot(t,TimeResponse1e6)
% title('Time Response' ) ;

figure() 
 
num_bin = 10;
[counts, bins] = hist(TimeResponse1e6,num_bin);
num_data = numel( TimeResponse1e6 ) ;
plot( bins, counts./num_data ) ;
title('PDF');