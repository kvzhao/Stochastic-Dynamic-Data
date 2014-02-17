clc ;  close all ; 
% clear all ;
% load ensemble1e3_1e4sec.mat

w = ensemble( :, 1:1000 ) ; 
ensembleAverage = mean( w ,1) ; 
plot( ensembleAverage(1:400) );

