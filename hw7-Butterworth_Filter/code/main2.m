clc; clear all; close all ; 
%%====================================================================================

  n = 1e4; 
  w = wgn(n,1,0) ; 

%% filter design 
sys = filterDesign( 1 ) ; 


% myfft(w) ; 
% y = lsim( sys,w,0:length( w )-1 ) ;


