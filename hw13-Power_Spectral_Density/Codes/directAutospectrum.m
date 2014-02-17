function Gx = directAutospectrum(x)
X = abs( fft(x) ) ; 
T = length(x) ; 
Gx = 2*X.^2/T;
end
