% image toolbox
% MATLAB file
% 
% snr.m
% compute signal-to-noise-ratio (SNR) of a noisy signal/image
%
% function s = snr(noisydata, original)
%
% input:  noisydata: noisy data
%         original:  clean data
% output: s: SNR value
% example: s = snr(f, eu);
%
% created:       11/23/2003
% last modified: 03/31/2009
% author:        jjxu@ucla
%                syleung@gmail

function s = snr(noisydata, original)

mean_original = mean(original(:));
tmp           = original - mean_original;
var_original  = sum(tmp(:).^2);

noise      = noisydata - original;
mean_noise = mean(noise(:));
tmp        = noise - mean_noise;
var_noise  = sum(tmp(:).^2);

if var_noise == 0
    s = 999.99; %% INF. clean image
else
    s = 10 * log10(var_original / var_noise);
end

return