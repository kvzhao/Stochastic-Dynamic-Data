function emu = est_mean( x ) 
    sum=0;
    for i=1:length(x) 
        sum = sum + x(i) ; 
    end
    emu = sum / length(x) ; 
end 