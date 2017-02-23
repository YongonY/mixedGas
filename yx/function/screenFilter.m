function [ret,num] = screenFilter( func,main,ref,threshold )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
spectrum_main = fft(main);
spectrum_ref = fft(ref);
spectrum_func = fft(func);
[ seri,num ] = screen( spectrum_main,spectrum_ref,threshold );
filter = zeros(length(spectrum_main),1);
filter(seri) = 1;
ret = ifft(spectrum_func.*filter);

end

